using Movie_Ticket_Booking_Backend.Domain.Bookings;
using Movie_Ticket_Booking_Backend.Domain.Cinemas;
using Movie_Ticket_Booking_Backend.Domain.Movies;

namespace Movie_Ticket_Booking_Backend.Domain.Showtimes
{
    public class Showtime
    {
        public string ShowtimeId { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public string Status { get; set; }
        public string MovieId { get; set; }
        public Movie Movie { get; set; }
        public string RoomId { get; set; }
        public Room Room { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }

        public ICollection<ShowtimeTicketType> ShowtimeTicketTypes { get; set; }
        public ICollection<Booking> Bookings { get; set; }
        public ICollection<SeatLock> SeatLocks { get; set; }

    }
}
