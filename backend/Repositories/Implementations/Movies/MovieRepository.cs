using Microsoft.EntityFrameworkCore;
using Movie_Ticket_Booking_Backend.Data;
using Movie_Ticket_Booking_Backend.Domain.Movies;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Movies;

public class MovieRepository : IMovieRepository
{
    private readonly AppDbContext _context;

    public MovieRepository(AppDbContext context)
    {
        _context = context;
    }

    public async Task<List<Movie>> GetAllMovies()
    {
        return await _context.Movies.ToListAsync();
    }

    public async Task<Movie?> GetMovieById(string id)
    {
        return await _context.Movies.FirstOrDefaultAsync(x => x.MovieId.Equals(id));
    }

    public async Task AddMovie(Movie movie)
    {
        await _context.Movies.AddAsync(movie);
    }

    public void UpdateMovie(Movie movie)
    {
        _context.Movies.Update(movie);
    }

    public void DeleteMovie(Movie movie)
    {
        _context.Movies.Remove(movie);
    }

    public async Task Save()
    {
        await _context.SaveChangesAsync();
    }
}