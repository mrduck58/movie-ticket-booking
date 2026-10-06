using Movie_Ticket_Booking_Backend.Data;
using Movie_Ticket_Booking_Backend.Domain.Movies;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Movies;
using Microsoft.EntityFrameworkCore;

namespace Movie_Ticket_Booking_Backend.Repositories.Implementations.Movies
{
    public class WatchListRepository : IWatchListRepository
    {
        private readonly AppDbContext _context;

        public WatchListRepository(AppDbContext context)
        {
            _context = context;
        }

        public async Task<WatchList?> GetAsync(string userId, string movieId)
        {
            return await _context.WatchLists
                .FirstOrDefaultAsync(w => w.UserId == userId && w.MovieId == movieId);
        }

        public async Task<List<WatchList>> GetByUserIdAsync(string userId)
        {
            return await _context.WatchLists
     .Where(w => w.UserId == userId)
     .Include(w => w.Movie)
         .ThenInclude(m => m.Posters)
     .Include(w => w.Movie)
         .ThenInclude(m => m.MovieGenres)
             .ThenInclude(mg => mg.Genre)
     .OrderByDescending(w => w.CreatedAt)
     .ToListAsync();
        }

        public async Task AddAsync(WatchList watchList)
        {
            _context.WatchLists.Add(watchList);
            await _context.SaveChangesAsync();
        }

        public async Task DeleteAsync(WatchList watchList)
        {
            _context.WatchLists.Remove(watchList);
            await _context.SaveChangesAsync();
        }
    }
}
