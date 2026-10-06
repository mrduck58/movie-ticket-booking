namespace Movie_Ticket_Booking_Backend.DTOs.Cinema
{
    public class SeatRowDto
    {
        public string RowName { get; set; }

        public List<SeatDto> Seats { get; set; }
    }
}
