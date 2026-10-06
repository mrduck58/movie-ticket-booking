using Movie_Ticket_Booking_Backend.DTOs.Cinema;

namespace Movie_Ticket_Booking_Backend.Services.Interfaces.Cinemas
{
    public interface IFavoriteCinemaService
    {
        Task<bool> ToggleFavorite(string userId, string cinemaId);
        Task<List<CinemaDto>> GetFavoriteCinemas(string userId);
    }
}
