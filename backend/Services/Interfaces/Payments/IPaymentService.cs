namespace Movie_Ticket_Booking_Backend.Services.Interfaces.Payments
{
    public interface IPaymentService
    {
        Task<bool> Pay(string bookingId);
    }
}
