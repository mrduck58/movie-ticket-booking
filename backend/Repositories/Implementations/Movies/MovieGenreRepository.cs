using Microsoft.EntityFrameworkCore;
using Movie_Ticket_Booking_Backend.Data;
using Movie_Ticket_Booking_Backend.Domain.Movies;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Movies;

namespace Movie_Ticket_Booking_Backend.Repositories.Implementations.Movies
{
    public class MovieGenreRepository : IMovieGenreRepository
    {
        private readonly AppDbContext _context;

        public MovieGenreRepository(AppDbContext context)
        {
            _context = context;
        }
        public async Task<List<MovieGenre>> GetGenresByMovieId(string movieId)
        {
            return await _context.MovieGenres
                .Where(x => x.MovieId == movieId)
                .Include(x => x.Genre)
                .ToListAsync();
        }
    }
}
