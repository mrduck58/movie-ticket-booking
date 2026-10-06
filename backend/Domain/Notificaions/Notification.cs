using Movie_Ticket_Booking_Backend.Domain.Blogs;
using Movie_Ticket_Booking_Backend.Domain.Bookings;
using Movie_Ticket_Booking_Backend.Domain.Movies;
using Movie_Ticket_Booking_Backend.Domain.Users;

namespace Movie_Ticket_Booking_Backend.Domain.Notificaions
{
    public class Notification
    {
        public string NotificationId { get; set; } 

        public string UserId { get; set; }

        public string? WatchListId { get; set; }

        public string? BlogPostId { get; set; }

        public string? CommentId { get; set; }

        public string? BookingSeatId { get; set; }
        public string? BookingId { get; set; }

        public string Type { get; set; } = null!;
        public string Message { get; set; }

        public bool IsRead { get; set; } = false;

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;


        public User User { get; set; }

        public WatchList? WatchList { get; set; }

        public BlogPost? BlogPost { get; set; }

        public Comment? Comment { get; set; }

        public BookingSeat? BookingSeat { get; set; }
    }
}
