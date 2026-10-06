using Movie_Ticket_Booking_Backend.Domain.Vouchers;

namespace Movie_Ticket_Booking_Backend.Domain.Bookings
{
    public class BookingVoucher
    {
        public string BookingId { get; set; }
        public Booking Booking { get; set; }
        public string VoucherId { get; set; }
        public Voucher Voucher { get; set; }
    }
}
