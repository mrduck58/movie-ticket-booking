using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Movie_Ticket_Booking_Backend.DTOs.Notifications;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Notifications;

namespace Movie_Ticket_Booking_Backend.Controllers.Notifications
{
    [ApiController]
    [Route("api/notifications")]
    [Authorize]
    public class NotificationController : ControllerBase
    {
        private readonly INotificationService _service;

        public NotificationController(INotificationService service)
        {
            _service = service;
        }

        private string GetUserIdFromToken()
        {
            var userId =
                User.FindFirst("UserId")?.Value ??
                User.FindFirst(ClaimTypes.NameIdentifier)?.Value ??
                User.FindFirst("sub")?.Value;

            if (string.IsNullOrEmpty(userId))
            {
                var claims = User.Claims.Select(c => $"{c.Type} = {c.Value}");
                throw new UnauthorizedAccessException(
                    "User ID not found in token. Claims: " + string.Join(" | ", claims)
                );
            }

            return userId;
        }

        [HttpGet]
        public async Task<IActionResult> GetUserNotifications()
        {
            try
            {
                var userId = GetUserIdFromToken();
                var result = await _service.GetUserNotifications(userId);

                if (!result.Any())
                    return NotFound(new { message = "No notifications found" });

                return Ok(result);
            }
            catch (UnauthorizedAccessException ex)
            {
                return Unauthorized(new { message = ex.Message });
            }
        }

        [HttpPut("{notificationId}/read")]
        public async Task<IActionResult> MarkAsRead(string notificationId)
        {
            try
            {
                var userId = GetUserIdFromToken();
                await _service.MarkAsRead(userId, notificationId);
                return Ok(new { message = "Notification marked as read" });
            }
            catch (UnauthorizedAccessException ex)
            {
                return Unauthorized(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                return NotFound(new { message = ex.Message });
            }
        }

        [HttpDelete("{notificationId}")]
        public async Task<IActionResult> Delete(string notificationId)
        {
            try
            {
                var userId = GetUserIdFromToken();
                await _service.DeleteNotification(userId, notificationId);
                return Ok(new { message = "Notification deleted" });
            }
            catch (UnauthorizedAccessException ex)
            {
                return Unauthorized(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                return NotFound(new { message = ex.Message });
            }
        }

        [HttpDelete("clear")]
        public async Task<IActionResult> ClearAll()
        {
            try
            {
                var userId = GetUserIdFromToken();
                await _service.ClearAll(userId);
                return Ok(new { message = "All notifications cleared" });
            }
            catch (UnauthorizedAccessException ex)
            {
                return Unauthorized(new { message = ex.Message });
            }
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] CreateNotificationDto dto)
        {
            if (dto == null)
                return BadRequest(new { message = "Invalid request body" });

            if (string.IsNullOrWhiteSpace(dto.UserId))
                return BadRequest(new { message = "UserId is required" });

            if (string.IsNullOrWhiteSpace(dto.Type))
                return BadRequest(new { message = "Type is required" });

            if (string.IsNullOrWhiteSpace(dto.Message))
                return BadRequest(new { message = "Message is required" });

            try
            {
                await _service.CreateNotification(dto);
                return Ok(new { message = "Notification created" });
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }
    }
}