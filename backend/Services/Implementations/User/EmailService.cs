namespace Movie_Ticket_Booking_Backend.Services.Implementations.User
{
    using MailKit.Net.Smtp;
    using MimeKit;

    public class EmailService : IEmailService
    {
        private readonly IConfiguration _config;
        public EmailService(IConfiguration config) => _config = config;

        public async Task SendEmailAsync(string email, string subject, string message)
        {
            var emailMessage = new MimeKit.MimeMessage();
            emailMessage.From.Add(new MailboxAddress("VPHAN Booking", _config["EmailSettings:Sender"]));
            emailMessage.To.Add(new MailboxAddress("", email));
            emailMessage.Subject = subject;
            emailMessage.Body = new TextPart("html") { Text = message };

            using (var client = new SmtpClient())
            {
                await client.ConnectAsync("smtp.gmail.com", 587, MailKit.Security.SecureSocketOptions.StartTls);
                await client.AuthenticateAsync(_config["EmailSettings:Sender"], _config["EmailSettings:Password"]);
                await client.SendAsync(emailMessage);
                await client.DisconnectAsync(true);
            }
        }
    }
}
