namespace Movie_Ticket_Booking_Backend.DTOs.Showtime
{
    public class ShowtimeGroupDto
    {
        public string TicketType { get; set; }
        public double Price { get; set; }
        public List<ShowtimeItemDto> Showtimes { get; set; }
    }
}
