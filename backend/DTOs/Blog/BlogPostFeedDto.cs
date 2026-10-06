namespace Movie_Ticket_Booking_Backend.DTOs.Blog
{

    public class BlogPostFeedDto
    {
        public string Id { get; set; }

        public string Name { get; set; }

        public string Avatar { get; set; }

        public DateTime CreatedAt { get; set; }

        public string Content { get; set; }

        public string Image { get; set; }

        public int Likes { get; set; }

        public bool IsLiked { get; set; }

    }
}