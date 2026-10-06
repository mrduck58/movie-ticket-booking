using Movie_Ticket_Booking_Backend.Domain.Movies;

namespace Movie_Ticket_Booking_Backend.Repositories.Interfaces.Movies
{
    public interface IMovieCastRepository
    {
        Task<List<MovieCast>> GetCastsByMovieId(string movieId);
    }
}