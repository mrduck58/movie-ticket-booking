using Microsoft.EntityFrameworkCore;
using Movie_Ticket_Booking_Backend.Data;
using Movie_Ticket_Booking_Backend.Domain.Bookings;
using Movie_Ticket_Booking_Backend.Domain.Cinemas;

public class SeatLockRepository : ISeatLockRepository
{
    private readonly AppDbContext _context;

    public SeatLockRepository(AppDbContext context)
    {
        _context = context;
    }

    public async Task<SeatLock?> GetActiveLock(string seatId, string showtimeId)
    {
        return await _context.SeatLocks
            .FirstOrDefaultAsync(x =>
                x.SeatId == seatId &&
                x.ShowtimeId == showtimeId &&
                x.ExpiredAt > DateTime.UtcNow);
    }

    public async Task AddLock(SeatLock seatLock)
    {
        await _context.SeatLocks.AddAsync(seatLock);
    }

    public async Task RemoveLock(string seatId, string showtimeId)
    {
        var lockSeat = await _context.SeatLocks
            .FirstOrDefaultAsync(x => x.SeatId == seatId && x.ShowtimeId == showtimeId);

        if (lockSeat != null)
            _context.SeatLocks.Remove(lockSeat);
    }

    public async Task Save()
    {
        await _context.SaveChangesAsync();
    }
}