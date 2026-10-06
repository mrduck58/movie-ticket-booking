namespace Movie_Ticket_Booking_Backend.DTOs.Payment
{
    public class PaymentMethodDto
    {
        public string PaymentMethodId { get; set; }

        public string Name { get; set; }

        public string ImageUrl { get; set; }

        public string Status { get; set; }
    }
}
