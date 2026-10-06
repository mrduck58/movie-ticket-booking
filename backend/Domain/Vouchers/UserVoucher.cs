using Movie_Ticket_Booking_Backend.Domain.Users;

namespace Movie_Ticket_Booking_Backend.Domain.Vouchers
{
    public class UserVoucher
    {
        public string UserVoucherId { get; set; }
        public string UserId { get; set; }
        public string VoucherId { get; set; }
        public User User { get; set; }
        public Voucher Voucher { get; set; }
        public string Status { get; set; }
        public DateTime? UsedAt { get; set; }
    }
}
