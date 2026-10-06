namespace Movie_Ticket_Booking_Backend.DTOs.Vouchers
{
    public class VoucherDto
    {
        public string VoucherId { get; set; }
        public string Code { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string Type { get; set; } // "PERCENTAGE" or "FIXED_AMOUNT"
        public double Value { get; set; }
        public DateTime ExpiredDate { get; set; }
        public string Status { get; set; }
    }
}
