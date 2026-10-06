using Movie_Ticket_Booking_Backend.DTOs.Ticket;

namespace Movie_Ticket_Booking_Backend.Services.Interfaces.Ticket
{
    public interface ITicketService
    {
        Task<List<TicketItemDto>> GetMyTickets(string userId);
    }
}
