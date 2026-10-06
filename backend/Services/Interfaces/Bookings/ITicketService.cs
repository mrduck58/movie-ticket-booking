namespace Movie_Ticket_Booking_Backend.Services.Interfaces.Bookings
{
    public interface ITicketService
    {
        Task<bool> Checkin(string bookingSeatId);
    }
}
