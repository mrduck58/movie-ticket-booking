namespace Movie_Ticket_Booking_Backend.Domain.Movies
{
    public class Poster
    {
        public string PosterId { get; set; }
        public string Title { get; set; }
        public string ImageUrl { get; set; }
        public string MovieId { get; set; }
        public Movie Movie { get; set; }
    }
}
