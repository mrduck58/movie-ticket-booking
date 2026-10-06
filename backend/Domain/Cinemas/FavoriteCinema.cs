using Movie_Ticket_Booking_Backend.Domain.Users;
using Movie_Ticket_Booking_Backend.Domain.Cinemas;

namespace Movie_Ticket_Booking_Backend.Domain.Cinemas
{
    public class FavoriteCinema
    {
        public string FavoriteCinemaId { get; set; }
        public string UserId { get; set; }
        public string CinemaId { get; set; }
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        public User User { get; set; }
        public Cinema Cinema { get; set; }
    }
}
