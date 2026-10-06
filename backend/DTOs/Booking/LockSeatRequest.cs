namespace Movie_Ticket_Booking_Backend.DTOs.Booking
{
    public class LockSeatRequest
    {
        public string ShowtimeId { get; set; }
        public List<string> SeatIds { get; set; }
    }
}
