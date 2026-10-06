using Microsoft.EntityFrameworkCore;
using Movie_Ticket_Booking_Backend.Data;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Bookings;

namespace Movie_Ticket_Booking_Backend.Services.Implementations.Bookings
{
    public class TicketService : ITicketService
    {
        private readonly AppDbContext _context;

        public TicketService(AppDbContext context)
        {
            _context = context;
        }

        public async Task<bool> Checkin(string bookingSeatId)
        {
            var seat = await _context.BookingSeats
                .FirstOrDefaultAsync(x => x.BookingSeatId == bookingSeatId);

            if (seat == null)
                return false;

            if (seat.Status == "CHECKED_IN")
                return false;

            seat.Status = "CHECKED_IN";
            seat.CheckinTime = DateTime.UtcNow;

            await _context.SaveChangesAsync();

            return true;
        }
    }
}
