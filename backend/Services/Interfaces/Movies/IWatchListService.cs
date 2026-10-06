using Movie_Ticket_Booking_Backend.DTOs.Movie;

namespace Movie_Ticket_Booking_Backend.Services.Interfaces.Movies
{
    public interface IWatchListService
    {
        Task AddAsync(string userId, AddWatchListDto dto);
        Task<List<WatchListDto>> GetUserWatchList(string userId);
        Task RemoveAsync(string userId, string movieId);
    }
}