namespace Movie_Ticket_Booking_Backend.Domain.Payments
{
    public class PaymentMethod
    {
        public string PaymentMethodId { get; set; }
        public string Name { get; set; }
        public string ImageUrl { get; set; }
        public string Status { get; set; } = "ACTIVE";
        public DateTime CreatedDate { get; set; }
        public DateTime UpdatedDate { get; set; }

        public ICollection<Payment> Payments { get; set; }
    }
}
