using Movie_Ticket_Booking_Backend.DTOs.Movie;

public interface IGenreService
{
    Task<List<GenreDto>> GetGenres();
    Task<GenreDto> CreateGenre(CreateGenreRequest request);
    Task<bool> DeleteGenre(string id);
}