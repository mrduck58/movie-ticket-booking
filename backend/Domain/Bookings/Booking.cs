using Movie_Ticket_Booking_Backend.Domain.Payments;
using Movie_Ticket_Booking_Backend.Domain.Users;
using Movie_Ticket_Booking_Backend.Domain.Showtimes;

namespace Movie_Ticket_Booking_Backend.Domain.Bookings
{
    public class Booking
    {
        public string BookingId { get; set; }
        public string UserId { get; set; }
        public User User { get; set; }
        public string ShowtimeId { get; set; }
        public Showtime Showtime { get; set; }
        public double TotalAmount { get; set; }
        public string Status { get; set; }
        public long OrderCode { get; set; }
        public DateTime CreatedAt { get; set; }
        public Payment Payment { get; set; }

        public ICollection<BookingVoucher> BookingVouchers { get; set; }
        public ICollection<BookingFoodCombo> BookingFoodCombos { get; set; }
        public ICollection<BookingSeat> BookingSeats { get; set; }
    }
}
