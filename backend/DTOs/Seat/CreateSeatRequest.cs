namespace Movie_Ticket_Booking_Backend.DTOs.Seat
{
    public class CreateSeatRequest
    {
        public string SeatName { get; set; }

        public string SeatType { get; set; }

        public string RoomId { get; set; }

        public string ShowtimeId { get; set; }
    }
}