using Movie_Ticket_Booking_Backend.Domain.Bookings;

namespace Movie_Ticket_Booking_Backend.Repositories.Interfaces.Ticket
{
    public interface ITicketRepository
    {
        Task<List<Booking>> GetBookingsByUserId(string userId);
    }
}
