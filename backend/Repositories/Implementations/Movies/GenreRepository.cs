using Microsoft.EntityFrameworkCore;
using Movie_Ticket_Booking_Backend.Data;
using Movie_Ticket_Booking_Backend.Domain.Movies;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Movies;

namespace Movie_Ticket_Booking_Backend.Repositories.Implementations.Movies
{
    public class GenreRepository : IGenreRepository
    {
        private readonly AppDbContext _context;

        public GenreRepository(AppDbContext context)
        {
            _context = context;
        }

        public async Task<List<Genre>> GetGenres()
        {
            return await _context.Genres.ToListAsync();
        }

        public async Task AddGenre(Genre genre)
        {
            await _context.Genres.AddAsync(genre);
        }
        public async Task<Genre?> GetGenreById(string id)
        {
            return await _context.Genres.FirstOrDefaultAsync(x => x.GenreId.Equals(id));
        }

        public void UpdateGenre(Genre genre)
        {
            _context.Genres.Update(genre);
        }

        public void DeleteGenre(Genre genre)
        {
            _context.Genres.Remove(genre);
        }

        public async Task Save()
        {
            await _context.SaveChangesAsync();
        }
    }
}
