namespace Movie_Ticket_Booking_Backend.DTOs.Cinema
{
    public class CreateCinemaRequest
    {
        public string CinemaId { get; set; }
        public string Name { get; set; }
        public string Location { get; set; }
        public string Rating { get; set; }
        public string Hotline { get; set; }
    }
}
