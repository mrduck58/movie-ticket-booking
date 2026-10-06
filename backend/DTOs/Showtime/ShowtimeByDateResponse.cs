namespace Movie_Ticket_Booking_Backend.DTOs.Showtime
{
    public class ShowtimeByDateResponse
    {
        public DateTime Date { get; set; }
        public List<ShowtimeGroupDto> Groups { get; set; }
    }
}
