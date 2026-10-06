using Microsoft.EntityFrameworkCore;
using Movie_Ticket_Booking_Backend.Data;
using Movie_Ticket_Booking_Backend.Domain.Showtimes;

public class ShowtimeRepository : IShowtimeRepository
{
    private readonly AppDbContext _context;

    public ShowtimeRepository(AppDbContext context)
    {
        _context = context;
    }
    public async Task<List<Showtime>> GetByMovieCinemaDate(
        string movieId,
        string cinemaId,
        DateTime date)
    {
        return await _context.Showtimes
            .Where(s =>
                s.MovieId == movieId &&
                s.Room.CinemaId == cinemaId &&
                s.StartTime.Date == date.Date
            )
            .Include(s => s.Room)
            .Include(s => s.ShowtimeTicketTypes)
                .ThenInclude(st => st.TicketType)
            .ToListAsync();
    }

    public async Task<Showtime> GetShowtimeAsync(string showtimeId)
    {
        return await _context.Showtimes
            .Include(x => x.Room)
            .Include(x => x.ShowtimeTicketTypes)
            .FirstAsync(x => x.ShowtimeId == showtimeId);
    }

    public async Task<List<Showtime>> GetShowtimesByMovie(string movieId)
    {
        return await _context.Showtimes
            .Where(x => x.MovieId == movieId)
            .ToListAsync();
    }

    public async Task<List<Showtime>> GetShowtimesByRoom(string roomId)
    {
        return await _context.Showtimes
            .Where(x => x.RoomId == roomId)
            .ToListAsync();
    }

    public async Task AddShowtime(Showtime showtime)
    {
        await _context.Showtimes.AddAsync(showtime);
    }

    public async Task Save()
    {
        await _context.SaveChangesAsync();
    }
}