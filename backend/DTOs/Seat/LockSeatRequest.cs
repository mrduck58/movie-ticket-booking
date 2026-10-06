namespace Movie_Ticket_Booking_Backend.DTOs.Seat
{
    public class LockSeatRequest
    {
        public string ShowtimeId { get; set; }
        public string SeatId { get; set; }
    }
}
