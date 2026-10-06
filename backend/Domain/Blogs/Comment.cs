using Movie_Ticket_Booking_Backend.Domain.Notificaions;
using Movie_Ticket_Booking_Backend.Domain.Users;

namespace Movie_Ticket_Booking_Backend.Domain.Blogs
{
    public class Comment
    {
        public string CommentId { get; set; }
        public string UserId { get; set; }
        public User User { get; set; }
        public string BlogPostId { get; set; }
        public BlogPost BlogPost { get; set; }
        public string Content { get; set; }
        public DateTime CreatedDate { get; set; }

        public ICollection<Notification> Notifications { get; set; }
    }
}
