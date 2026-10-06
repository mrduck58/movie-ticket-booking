using Microsoft.EntityFrameworkCore;
using Movie_Ticket_Booking_Backend.Data;
using Movie_Ticket_Booking_Backend.Domain.Movies;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Movies;

namespace Movie_Ticket_Booking_Backend.Repositories.Implementations.Movies
{
    public class PosterRepository : IPosterRepository
    {
        private readonly AppDbContext _context;
        public PosterRepository(AppDbContext context)
        {
            _context = context;
        }

        public async Task<Poster?> GetPosterById(string id)
        {
            return await _context.Posters.FirstOrDefaultAsync(x => x.PosterId.Equals(id));
        }

        public async Task<List<Poster>> GetPostersByMovieId(string movieId)
        {
            return await _context.Posters.Where(x => x.MovieId.Equals(movieId)).ToListAsync();
        }

        public async Task Save()
        {
            await _context.SaveChangesAsync();
        }
    }
}
