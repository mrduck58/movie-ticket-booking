using Movie_Ticket_Booking_Backend.DTOs.Cinema;
using Movie_Ticket_Booking_Backend.DTOs.Movie;

public interface ICinemaService
{
    Task<List<CinemaDto>> GetCinemas(string? userId = null);
    Task<CinemaDto?> GetCinemaById(string id, string? userId = null);
    Task<List<CinemaListDto>> GetCinemasByMovie(string movieId);
    Task<CinemaDto> CreateCinema(CreateCinemaRequest request);
    Task<bool> DeleteCinema(string id);

    Task<List<MovieDto>> GetMoviesByCinema(string cinemaId);
}