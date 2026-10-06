namespace Movie_Ticket_Booking_Backend.DTOs.Movie
{
    public class CreateMovieRequest
    {
        public string Title { get; set; } = string.Empty;
        public string TitleVn { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public string TrailerUrl { get; set; } = string.Empty;
        public string Director { get; set; } = string.Empty;
        public double Duration { get; set; }
        public double Rating { get; set; }
    }
}
