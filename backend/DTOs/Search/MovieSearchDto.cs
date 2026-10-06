namespace Movie_Ticket_Booking_Backend.DTOs.Search
{
    public class MovieSearchDto
    {
        public string MovieId { get; set; }
        public string Title { get; set; }
        public string TitleVn { get; set; }
        public string PosterUrl { get; set; }
        public double Rating { get; set; }
        public double Duration { get; set; }
        public string Status { get; set; }
        public string Director { get; set; }
    }
}