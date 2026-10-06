namespace Movie_Ticket_Booking_Backend.Domain.Movies
{
    public class Genre
    {
        public string GenreId { get; set; }
        public string Name { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }

        public ICollection<MovieGenre> MovieGenres { get; set; }
        public ICollection<UserGenre> UserGenres { get; set; }
    }
}
