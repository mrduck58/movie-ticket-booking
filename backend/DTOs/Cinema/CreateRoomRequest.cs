namespace Movie_Ticket_Booking_Backend.DTOs.Cinema
{
    public class CreateRoomRequest
    {
        public string CinemaId { get; set; }
        public string RoomName { get; set; } = string.Empty;
    }
}
