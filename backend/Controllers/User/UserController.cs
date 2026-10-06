using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Movie_Ticket_Booking_Backend.DTOs.User;
using Movie_Ticket_Booking_Backend.Services.Implementations.User;

namespace Movie_Ticket_Booking_Backend.Controllers
{
    [ApiController]
    [Route("api/users")]
    public class UserController : ControllerBase
    {
        private readonly UserService _userService;

        public UserController(UserService userService)
        {
            _userService = userService;
        }

        [HttpPost("register")]
        public async Task<IActionResult> Register(RegisterUserRequest dto)
        {
            var user = await _userService.RegisterUser(dto);

            return Ok(new
            {
                message = "Register success",
                userId = user.UserId
            });
        }

        [Authorize]
        [HttpGet("me")]
        public async Task<IActionResult> GetMe()
        {
            var userId = User.FindFirst("UserId")?.Value;

            if (string.IsNullOrEmpty(userId))
                return Unauthorized();

            var user = await _userService.GetCurrentUser(userId);

            if (user == null)
                return NotFound();

            return Ok(new
            {
                fullName = user.FullName,
                avatarUrl = user.AvatarUrl
            });
        }
    }
}