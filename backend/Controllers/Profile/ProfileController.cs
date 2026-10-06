using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Movie_Ticket_Booking_Backend.DTOs.User;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Profile;

namespace Movie_Ticket_Booking_Backend.Controllers.Profile
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class ProfileController : ControllerBase
    {
        private readonly IProfileService _profileService;

        public ProfileController(IProfileService profileService)
        {
            _profileService = profileService;
        }

        [HttpGet]
        public async Task<IActionResult> GetProfile()
        {
            var userId = User.FindFirst("UserId")?.Value;

            var result = await _profileService.GetProfile(userId);

            return Ok(result);
        }

        [HttpPut]
        public async Task<IActionResult> UpdateProfile(
            [FromBody] UserProfileResponseDto request)
        {
            var userId = User.FindFirst("UserId")?.Value;

            await _profileService.UpdateProfile(userId, request);

            return Ok(new { message = "Update success" });
        }
    }
}
