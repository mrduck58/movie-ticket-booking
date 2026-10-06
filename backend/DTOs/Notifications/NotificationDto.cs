namespace Movie_Ticket_Booking_Backend.DTOs.Notifications
{
    public class NotificationDto
    {
        public string NotificationId { get; set; }
        public string Message { get; set; }
        public bool IsRead { get; set; }
        public DateTime CreatedAt { get; set; }
        public string Type { get; set; }
        public string? RelatedId { get; set; }
    }
}