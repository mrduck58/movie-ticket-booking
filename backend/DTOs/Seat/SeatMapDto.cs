namespace Movie_Ticket_Booking_Backend.DTOs.Cinema
{
    public class SeatMapDto
    {
        public string ShowtimeId { get; set; }
        public string RoomName { get; set; }

        public List<SeatDto> Seats { get; set; }
    }
}
