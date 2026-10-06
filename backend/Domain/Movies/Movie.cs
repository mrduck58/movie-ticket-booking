using Movie_Ticket_Booking_Backend.Domain.Showtimes;

namespace Movie_Ticket_Booking_Backend.Domain.Movies
{
    public class Movie
    {
        public string MovieId { get; set; }
        public string Title { get; set; }
        public string TitleVn { get; set; }
        public string Description { get; set; }
        public string TrailerUrl { get; set; }
        public double Duration { get; set; }
        public double Rating { get; set; }
        public string Director { get; set; }
        public string Status { get; set; } = "ACTIVE";
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }

        public ICollection<Poster> Posters { get; set; }
        public ICollection<MovieGenre> MovieGenres { get; set; }
        public ICollection<MovieCast> MovieCasts { get; set; }
        public ICollection<MovieRating>? MovieRatings { get; set; }
        public ICollection<Showtime> Showtimes { get; set; }
        public ICollection<WatchList> WatchLists { get; set; }
    }
}
