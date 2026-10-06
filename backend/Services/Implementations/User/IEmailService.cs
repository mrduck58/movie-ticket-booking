namespace Movie_Ticket_Booking_Backend.Services.Implementations.User
{
    public interface IEmailService
    {
        Task SendEmailAsync(string email, string subject, string message);
    }
}
