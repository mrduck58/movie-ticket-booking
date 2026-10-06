using Movie_Ticket_Booking_Backend.Domain.Cinemas;
using Movie_Ticket_Booking_Backend.DTOs.Cinema;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Cinemas;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Cinemas;

namespace Movie_Ticket_Booking_Backend.Services.Implementations.Cinemas
{
    public class FavoriteCinemaService : IFavoriteCinemaService
    {
        private readonly IFavoriteCinemaRepository _favoriteRepository;
        private readonly ICinemaRepository _cinemaRepository;

        public FavoriteCinemaService(IFavoriteCinemaRepository favoriteRepository, ICinemaRepository cinemaRepository)
        {
            _favoriteRepository = favoriteRepository;
            _cinemaRepository = cinemaRepository;
        }

        public async Task<bool> ToggleFavorite(string userId, string cinemaId)
        {
            var existing = await _favoriteRepository.GetFavorite(userId, cinemaId);
            if (existing != null)
            {
                _favoriteRepository.RemoveFavorite(existing);
                await _favoriteRepository.Save();
                return false; // Result is NOT favorite
            }
            else
            {
                var favorite = new FavoriteCinema
                {
                    FavoriteCinemaId = Guid.NewGuid().ToString(),
                    UserId = userId,
                    CinemaId = cinemaId,
                    CreatedAt = DateTime.UtcNow
                };
                await _favoriteRepository.AddFavorite(favorite);
                await _favoriteRepository.Save();
                return true; // Result is favorite
            }
        }

        public async Task<List<CinemaDto>> GetFavoriteCinemas(string userId)
        {
            var favorites = await _favoriteRepository.GetFavoriteCinemas(userId);
            return favorites.Select(f => new CinemaDto
            {
                CinemaId = f.Cinema.CinemaId,
                Name = f.Cinema.Name,
                Location = f.Cinema.Location,
                Rating = f.Cinema.Rating,
                Hotline = f.Cinema.Hotline,
                IsFavorite = true
            }).ToList();
        }
    }
}
