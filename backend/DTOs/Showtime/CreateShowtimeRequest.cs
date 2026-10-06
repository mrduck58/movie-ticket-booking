namespace Movie_Ticket_Booking_Backend.DTOs.Showtime
{
    public class CreateShowtimeRequest
    {
        public string MovieId { get; set; }

        public string RoomId { get; set; }

        public DateTime StartTime { get; set; }

        public DateTime EndTime { get; set; }
    }
}
