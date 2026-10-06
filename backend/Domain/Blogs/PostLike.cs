using Movie_Ticket_Booking_Backend.Domain.Users;
namespace Movie_Ticket_Booking_Backend.Domain.Blogs
{
    public class PostLike
    {
        public string PostLikeId { get; set; }

        public string BlogPostId { get; set; }
        public BlogPost BlogPost { get; set; }

        public string UserId { get; set; }
        public User User { get; set; }

        public DateTime CreatedAt { get; set; }
    }
}
