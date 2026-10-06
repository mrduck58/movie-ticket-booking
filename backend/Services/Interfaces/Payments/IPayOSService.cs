using Movie_Ticket_Booking_Backend.Domain.Bookings;

namespace Movie_Ticket_Booking_Backend.Services.Interfaces.Payments
{
    public interface IPayOSService
    {
        Task<string> CreatePaymentLink(Booking booking);
        Task<bool> HandleWebhook(string webhookBody);
        Task<long?> GetVerifiedOrderCode(string webhookBody);
        Task<string?> GetPaymentStatus(long orderCode);
    }
}
