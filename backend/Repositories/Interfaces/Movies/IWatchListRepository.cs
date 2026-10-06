using Movie_Ticket_Booking_Backend.Domain.Movies;

namespace Movie_Ticket_Booking_Backend.Repositories.Interfaces.Movies
{
    public interface IWatchListRepository
    {
        Task<WatchList?> GetAsync(string userId, string movieId);

        Task<List<WatchList>> GetByUserIdAsync(string userId);

        Task AddAsync(WatchList watchList);

        Task DeleteAsync(WatchList watchList);
    }
}
