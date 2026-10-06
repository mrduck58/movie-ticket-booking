namespace Movie_Ticket_Booking_Backend.DTOs.Notifications
{
    public class CreateNotificationDto
    {
        public string UserId { get; set; }
        public string Type { get; set; }

        public string? WatchListId { get; set; }
        public string? BlogPostId { get; set; }
        public string? CommentId { get; set; }
        public string? BookingSeatId { get; set; }
        public string? BookingId { get; set; }

        public string Message { get; set; }
    }
}