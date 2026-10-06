using Movie_Ticket_Booking_Backend.Domain.Cinemas;

namespace Movie_Ticket_Booking_Backend.Repositories.Interfaces.Cinemas
{
    public interface IFavoriteCinemaRepository
    {
        Task<FavoriteCinema?> GetFavorite(string userId, string cinemaId);
        Task<List<FavoriteCinema>> GetFavoriteCinemas(string userId);
        Task AddFavorite(FavoriteCinema favorite);
        void RemoveFavorite(FavoriteCinema favorite);
        Task Save();
    }
}
