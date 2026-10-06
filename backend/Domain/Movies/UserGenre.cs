using Movie_Ticket_Booking_Backend.Domain.Users;

namespace Movie_Ticket_Booking_Backend.Domain.Movies
{
    public class UserGenre
    {
        public string UserId { get; set; }
        public string GenreId { get; set; }

        public User User { get; set; }
        public Genre Genre { get; set; }
    }
}
