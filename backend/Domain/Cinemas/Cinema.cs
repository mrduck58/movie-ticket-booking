namespace Movie_Ticket_Booking_Backend.Domain.Cinemas
{
    public class Cinema
    {
        public string CinemaId { get; set; }
        public string Name { get; set; }
        public string Location { get; set; }
        public string Rating { get; set; }
        public string Hotline { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }

        public ICollection<Room> Rooms { get; set; }
        public ICollection<FavoriteCinema> FavoriteCinemas { get; set; }
    }
}
