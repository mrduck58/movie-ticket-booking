using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Movie_Ticket_Booking_Backend.DTOs.Movie;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Movies;

namespace Movie_Ticket_Booking_Backend.Controllers.Movie
{
    [ApiController]
    [Route("api/watchlist")]
    [Authorize]
    public class WatchListController : ControllerBase
    {
        private readonly IWatchListService _service;

        public WatchListController(IWatchListService service)
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
        [HttpPost]
        public async Task<IActionResult> Add([FromBody] AddWatchListDto dto)
        {
            try
            {
                var userId = GetUserIdFromToken();
                await _service.AddAsync(userId, dto);
                return Ok("Added to watchlist");
            }
            catch (UnauthorizedAccessException ex)
            {
                return Unauthorized(ex.Message);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            try
            {
                var userId = GetUserIdFromToken();
                var result = await _service.GetUserWatchList(userId);

                if (result == null || !result.Any())
                    return NotFound("Watchlist not found");

                return Ok(result);
            }
            catch (UnauthorizedAccessException ex)
            {
                return Unauthorized(new { message = ex.Message });
            }
        }
        [HttpDelete("{movieId}")]
        public async Task<IActionResult> Remove(string movieId)
        {
            try
            {
                var userId = GetUserIdFromToken();
                await _service.RemoveAsync(userId, movieId);
                return Ok(new { message = "Removed from watchlist" });
            }
            catch (UnauthorizedAccessException ex)
            {
                return Unauthorized(new { message = ex.Message });
            }
            catch
            {
                return NotFound(new { message = "Watchlist item not found" });
            }
        }
    }
}