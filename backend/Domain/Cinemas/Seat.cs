using Movie_Ticket_Booking_Backend.Domain.Bookings;
using Movie_Ticket_Booking_Backend.Domain.Showtimes;

namespace Movie_Ticket_Booking_Backend.Domain.Cinemas
{
    public class Seat
    {
        public string SeatId { get; set; }
        public string SeatName { get; set; }
        public string RoomId { get; set; }
        public Room Room { get; set; }

        public ICollection<BookingSeat> BookingSeats { get; set; }
        public ICollection<SeatLock> SeatLocks { get; set; }
    }
}
