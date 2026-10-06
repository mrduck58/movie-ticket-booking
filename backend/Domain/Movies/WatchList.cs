using Movie_Ticket_Booking_Backend.Domain.Notificaions;
using Movie_Ticket_Booking_Backend.Domain.Users;

namespace Movie_Ticket_Booking_Backend.Domain.Movies
{
    public class WatchList
    {
        public string WatchListId { get; set; }

        public string UserId { get; set; }

        public string MovieId { get; set; }
        public string type { get; set; }
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public User User { get; set; }
        public Movie Movie { get; set; }
        public ICollection<Notification> Notifications { get; set; }
    }
}
