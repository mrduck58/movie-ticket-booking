using Movie_Ticket_Booking_Backend.Domain.Users;
using Movie_Ticket_Booking_Backend.Domain.Showtimes;

namespace Movie_Ticket_Booking_Backend.Domain.Cinemas
{
    public class SeatLock
    {
        public string SeatLockId { get; set; }
        public string ShowtimeId { get; set; }
        public Showtime Showtime { get; set; }
        public string SeatId { get; set; }
        public Seat Seat { get; set; }
        public string UserId { get; set; }
        public User User { get; set; }
        public DateTime LockedAt { get; set; }
        public DateTime ExpiredAt { get; set; }
    }
}
