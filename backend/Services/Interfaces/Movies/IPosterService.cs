using Movie_Ticket_Booking_Backend.DTOs.Movie;

namespace Movie_Ticket_Booking_Backend.Services.Interfaces.Movies
{
    public interface IPosterService
    {
        Task<List<PosterDto>> GetPostersByMovieId(string movieId);
    }
}
