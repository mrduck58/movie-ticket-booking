using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Cinemas;

namespace Movie_Ticket_Booking_Backend.Controllers.Cinema
{
    [ApiController]
    [Route("api/cinemas/favorites")]
    public class FavoriteCinemaController : ControllerBase
    {
        private readonly IFavoriteCinemaService _favoriteService;

        public FavoriteCinemaController(IFavoriteCinemaService favoriteService)
        {
            _favoriteService = favoriteService;
        }

        [Authorize]
        [HttpPost("{cinemaId}")]
        public async Task<IActionResult> ToggleFavorite(string cinemaId)
        {
            var userId = User.FindFirst("id")?.Value ?? User.FindFirst("UserId")?.Value;
            if (string.IsNullOrEmpty(userId))
                return Unauthorized();

            var isFavorite = await _favoriteService.ToggleFavorite(userId, cinemaId);
            return Ok(new { isFavorite });
        }

        [Authorize]
        [HttpGet]
        public async Task<IActionResult> GetFavorites()
        {
            var userId = User.FindFirst("id")?.Value ?? User.FindFirst("UserId")?.Value;
            if (string.IsNullOrEmpty(userId))
                return Unauthorized();

            var favorites = await _favoriteService.GetFavoriteCinemas(userId);
            return Ok(favorites);
        }
    }
}
