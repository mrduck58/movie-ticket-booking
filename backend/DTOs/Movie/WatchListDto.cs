namespace Movie_Ticket_Booking_Backend.DTOs.Movie
{
    public class WatchListDto
    {
        public string WatchListId { get; set; }

        public string MovieId { get; set; }

        public string Title { get; set; }

        public string PosterUrl { get; set; }

        public string type { get; set; }

        public DateTime CreatedAt { get; set; }

        public double Duration { get; set; }
        public string Director { get; set; }
        public double Rating { get; set; }
        public List<string> Genres { get; set; }
    }
}
