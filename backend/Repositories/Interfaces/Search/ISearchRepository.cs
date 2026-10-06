using Movie_Ticket_Booking_Backend.Domain.Movies;
using Movie_Ticket_Booking_Backend.Domain.Cinemas;

namespace Movie_Ticket_Booking_Backend.Repositories.Interfaces.Search
{
    public interface ISearchRepository
    {
        Task<List<Movie>> SearchMoviesAsync(string keyword);

        Task<List<Cinema>> SearchCinemasAsync(string keyword);
    }
}
