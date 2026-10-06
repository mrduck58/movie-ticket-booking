using Movie_Ticket_Booking_Backend.DTOs.Seat;

namespace Movie_Ticket_Booking_Backend.Services.Interfaces.Cinemas
{
    public interface ISeatLockService
    {
        Task<bool> LockSeat(string userId, LockSeatRequest request);
    }
}
