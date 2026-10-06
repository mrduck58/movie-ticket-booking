using Movie_Ticket_Booking_Backend.Data;
using Movie_Ticket_Booking_Backend.Domain.Cinemas;
using Movie_Ticket_Booking_Backend.Domain.Movies;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Search;
using Microsoft.EntityFrameworkCore;

namespace Movie_Ticket_Booking_Backend.Repositories.Implementations.Search
{
    public class SearchRepository : ISearchRepository
    {
        private readonly AppDbContext _context;

        public SearchRepository(AppDbContext context)
        {
            _context = context;
        }

        public async Task<List<Movie>> SearchMoviesAsync(string keyword)
        {
            keyword = keyword.Trim().ToLower();

            return await _context.Movies
                .Where(m =>
                    m.Title.ToLower().Contains(keyword) ||
                    m.TitleVn.ToLower().Contains(keyword) ||
                    m.Director.ToLower().Contains(keyword)
                )
                .Include(m => m.Posters)
                .ToListAsync();
        }

        public async Task<List<Cinema>> SearchCinemasAsync(string keyword)
        {
            keyword = keyword.Trim().ToLower();

            return await _context.Cinemas
                .Where(c =>
                    c.Name.ToLower().Contains(keyword) ||
                    c.Location.ToLower().Contains(keyword)
                )
                .ToListAsync();
        }
    }
}