using Movie_Ticket_Booking_Backend.Domain.Bookings;

namespace Movie_Ticket_Booking_Backend.Domain.Payments
{
    public class Payment
    {
        public string PaymentId { get; set; }
        public string BookingId { get; set; }
        public Booking Booking { get; set; }
        public string PaymentMethodId { get; set; }
        public PaymentMethod PaymentMethod { get; set; }
        public double Amount { get; set; }
        public string Status { get; set; } = "PENDING";
        public DateTime CreatedDate { get; set; }
    }
}
