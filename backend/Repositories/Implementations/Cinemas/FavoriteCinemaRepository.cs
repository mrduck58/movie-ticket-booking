using Microsoft.EntityFrameworkCore;
using Movie_Ticket_Booking_Backend.Data;
using Movie_Ticket_Booking_Backend.Domain.Cinemas;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Cinemas;

namespace Movie_Ticket_Booking_Backend.Repositories.Implementations.Cinemas
{
    public class FavoriteCinemaRepository : IFavoriteCinemaRepository
    {
        private readonly AppDbContext _context;

        public FavoriteCinemaRepository(AppDbContext context)
        {
            _context = context;
        }

        public async Task<FavoriteCinema?> GetFavorite(string userId, string cinemaId)
        {
            return await _context.FavoriteCinemas
                .FirstOrDefaultAsync(fc => fc.UserId == userId && fc.CinemaId == cinemaId);
        }

        public async Task<List<FavoriteCinema>> GetFavoriteCinemas(string userId)
        {
            return await _context.FavoriteCinemas
                .Include(fc => fc.Cinema)
                .Where(fc => fc.UserId == userId)
                .ToListAsync();
        }

        public async Task AddFavorite(FavoriteCinema favorite)
        {
            await _context.FavoriteCinemas.AddAsync(favorite);
        }

        public void RemoveFavorite(FavoriteCinema favorite)
        {
            _context.FavoriteCinemas.Remove(favorite);
        }

        public async Task Save()
        {
            await _context.SaveChangesAsync();
        }
    }
}
