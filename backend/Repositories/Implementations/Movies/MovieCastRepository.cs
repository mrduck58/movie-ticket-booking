using Microsoft.EntityFrameworkCore;
using Movie_Ticket_Booking_Backend.Data;
using Movie_Ticket_Booking_Backend.Domain.Movies;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Movies;

public class MovieCastRepository : IMovieCastRepository
{
    private readonly AppDbContext _context;

    public MovieCastRepository(AppDbContext context)
    {
        _context = context;
    }

    public async Task<List<MovieCast>> GetCastsByMovieId(string movieId)
    {
        return await _context.MovieCasts
            .Where(x => x.MovieId == movieId)
            .Include(x => x.Cast) 
            .ToListAsync();
    }
}