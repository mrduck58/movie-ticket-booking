using Movie_Ticket_Booking_Backend.Domain.Bookings;
using Movie_Ticket_Booking_Backend.Domain.Cinemas;

public interface ISeatLockRepository
{
    Task<SeatLock?> GetActiveLock(string seatId, string showtimeId);

    Task AddLock(SeatLock seatLock);

    Task RemoveLock(string seatId, string showtimeId);

    Task Save();
}