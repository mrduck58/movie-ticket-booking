using Movie_Ticket_Booking_Backend.Domain.Bookings;

namespace Movie_Ticket_Booking_Backend.Domain.Vouchers
{
    public class Voucher
    {
        public string VoucherId { get; set; }
        public string Code { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string Type { get; set; } // "PERCENTAGE" or "FIXED_AMOUNT"
        public double Value { get; set; }
        public string Status { get; set; } = "ACTIVE";
        public DateTime CreatedDate { get; set; }
        public DateTime ExpiredDate { get; set; }

        public ICollection<BookingVoucher> BookingVouchers { get; set; }
        public ICollection<UserVoucher> UserVouchers { get; set; }
    }
}
