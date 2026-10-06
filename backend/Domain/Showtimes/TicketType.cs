namespace Movie_Ticket_Booking_Backend.Domain.Showtimes
{
    public class TicketType
    {
        public string TicketTypeId { get; set; }
        public string Name { get; set; }
        public string Status { get; set; } = "ACTIVE";
        public ICollection<ShowtimeTicketType> ShowtimeTicketTypes { get; set; }
    }
}
