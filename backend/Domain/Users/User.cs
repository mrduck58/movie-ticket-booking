using Movie_Ticket_Booking_Backend.Domain.Blogs;
using Movie_Ticket_Booking_Backend.Domain.Bookings;
using Movie_Ticket_Booking_Backend.Domain.Cinemas;
using Movie_Ticket_Booking_Backend.Domain.Movies;
using Movie_Ticket_Booking_Backend.Domain.Notificaions;
using Movie_Ticket_Booking_Backend.Domain.Vouchers;


namespace Movie_Ticket_Booking_Backend.Domain.Users
{
    public class User
    {
        public string UserId { get; set; }
        
        public string Phone { get; set; }

        public string Email { get; set; }

        public string PasswordHash { get; set; }

        public string FullName { get; set; }

        public string AvatarUrl { get; set; }

        public string Status { get; set; } = "ACTIVE";

        public DateTime CreatedAt { get; set; }

        public DateTime DateOfBirth { get; set; }
        public DateTime UpdatedAt { get; set; }

        public string RoleId { get; set; }

        public Role Role { get; set; }
        // BỔ SUNG
        public string? Gender { get; set; }
        //public DateTime? Birthday { get; set; }
        public string? CCCD { get; set; }
        public string? Address { get; set; }
        public string? Hometown { get; set; }

        public ICollection<MovieRating> MovieRatings { get; set; }
        public ICollection<Booking> Bookings { get; set; }
        public ICollection<SeatLock> SeatLocks { get; set; }
        public ICollection<BlogPost> BlogPosts { get; set; }
        public ICollection<Comment> Comments { get; set; }
        public ICollection<WatchList> WatchLists { get; set; }
        public ICollection<UserGenre> UserGenres { get; set; }
        public ICollection<Notification> Notifications { get; set; }
        public ICollection<PostLike> PostLikes { get; set; }
        public ICollection<UserVoucher> UserVouchers { get; set; }
        public ICollection<FavoriteCinema> FavoriteCinemas { get; set; }
    }
}
