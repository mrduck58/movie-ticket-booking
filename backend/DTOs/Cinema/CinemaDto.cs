namespace Movie_Ticket_Booking_Backend.DTOs.Cinema
{
    public class CinemaDto
    {
        public string CinemaId { get; set; }
        public string Name { get; set; } = string.Empty;
        public string Location { get; set; } = string.Empty;
        public string Rating { get; set; } = string.Empty;
        public string Hotline { get; set; } = string.Empty;
        public bool IsFavorite { get; set; }
    }
}
