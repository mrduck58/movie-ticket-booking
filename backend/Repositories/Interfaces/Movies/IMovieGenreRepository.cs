using Movie_Ticket_Booking_Backend.Domain.Movies;

namespace Movie_Ticket_Booking_Backend.Repositories.Interfaces.Movies
{
    public interface IMovieGenreRepository
    {
        Task<List<MovieGenre>> GetGenresByMovieId(string movieId);
    }
}
