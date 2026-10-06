using Microsoft.EntityFrameworkCore;
using Movie_Ticket_Booking_Backend.Data;
using Movie_Ticket_Booking_Backend.Domain.Cinemas;
using Movie_Ticket_Booking_Backend.Domain.Movies;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Cinemas;

public class CinemaRepository : ICinemaRepository
{
    private readonly AppDbContext _context;

    public CinemaRepository(AppDbContext context)
    {
        _context = context;
    }

    public async Task AddCinema(Cinema cinema)
    {
        await _context.Cinemas.AddAsync(cinema);
    }

    public void DeleteCinema(Cinema cinema)
    {
        _context.Cinemas.Remove(cinema);
    }

    public async Task<Cinema?> GetCinemaById(string id)
    {
        return await _context.Cinemas.FirstOrDefaultAsync(x => x.CinemaId.Equals(id));
    }

    public async Task<List<Cinema>> GetCinemas()
    {
        return await _context.Cinemas.ToListAsync();
    }

    public async Task<List<Cinema>> GetCinemasByMovieId(string movieId)
    {
        return await _context.Showtimes
        .Where(s => s.MovieId == movieId)
        .Select(s => s.Room.Cinema)
        .Distinct()
        .ToListAsync();
    }

    public async Task Save()
    {
        await _context.SaveChangesAsync();
    }

    public void UpdateCinema(Cinema cinema)
    {
        _context.Cinemas.Update(cinema);
    }
    public async Task<List<Movie>> GetMoviesByCinemaId(string cinemaId)
    {
        return await _context.Showtimes
        .Where(s => s.Room.CinemaId == cinemaId)
        // Gọi Include TRƯỚC khi Select, thông qua navigation path
        .Include(s => s.Movie.Posters)
        .Select(s => s.Movie)
        .Distinct()
        .ToListAsync();
    }
}