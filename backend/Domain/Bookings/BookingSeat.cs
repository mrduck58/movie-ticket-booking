using Movie_Ticket_Booking_Backend.Domain.Cinemas;
using Movie_Ticket_Booking_Backend.Domain.Notificaions;
using Movie_Ticket_Booking_Backend.Domain.Showtimes;

namespace Movie_Ticket_Booking_Backend.Domain.Bookings
{
    public class BookingSeat
    {
        public string BookingSeatId { get; set; }
        public string BookingId { get; set; }
        public Booking Booking { get; set; }
        public string SeatId { get; set; }
        public Seat Seat { get; set; }
        public string ShowtimeTicketTypeId { get; set; }
        public ShowtimeTicketType ShowtimeTicketType { get; set; }
        public double Price { get; set; }
        public string QrCode { get; set; }
        public string Status { get; set; } = "BOOKED";
        public DateTime CheckinTime { get; set; }

        public ICollection<Notification> Notifications { get; set; }
    }
}
