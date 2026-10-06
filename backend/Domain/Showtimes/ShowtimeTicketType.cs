using Movie_Ticket_Booking_Backend.Domain.Bookings;

namespace Movie_Ticket_Booking_Backend.Domain.Showtimes
{
    public class ShowtimeTicketType
    {
        public string ShowtimeTicketTypeId { get; set; }
        public string ShowtimeId { get; set; }
        public Showtime Showtime { get; set; }
        public string TicketTypeId { get; set; }
        public TicketType TicketType { get; set; }
        public double Price { get; set; }

        public ICollection<BookingSeat> BookingSeats { get; set; }
    }
}
