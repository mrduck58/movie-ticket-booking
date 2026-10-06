using Movie_Ticket_Booking_Backend.DTOs.Movie;

namespace Movie_Ticket_Booking_Backend.Services.Interfaces.Movies
{
    public interface IMovieService
    {
        Task<List<MovieDto>> GetMovies();
        Task<MovieDto?> GetMovie(string id);
        Task<MovieDto> CreateMovie(CreateMovieRequest request);
        Task<bool> DeleteMovie(string id);
    }
}
