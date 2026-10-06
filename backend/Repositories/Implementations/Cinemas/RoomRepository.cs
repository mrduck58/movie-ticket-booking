using Microsoft.EntityFrameworkCore;
using Movie_Ticket_Booking_Backend.Data;
using Movie_Ticket_Booking_Backend.Domain.Cinemas;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Cinemas;

public class RoomRepository : IRoomRepository
{
    private readonly AppDbContext _context;

    public RoomRepository(AppDbContext context)
    {
        _context = context;
    }

    public async Task<List<Room>> GetRoomsByCinema(string cinemaId)
    {
        return await _context.Rooms
            .Where(x => x.CinemaId == cinemaId)
            .ToListAsync();
    }

    public async Task<Room?> GetRoom(string id)
    {
        return await _context.Rooms
            .FirstOrDefaultAsync(x => x.RoomId == id);
    }

    public async Task AddRoom(Room room)
    {
        await _context.Rooms.AddAsync(room);
    }

    public void DeleteRoom(Room room)
    {
        _context.Rooms.Remove(room);
    }

    public async Task Save()
    {
        await _context.SaveChangesAsync();
    }
}