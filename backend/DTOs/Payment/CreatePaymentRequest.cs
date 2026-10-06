namespace Movie_Ticket_Booking_Backend.DTOs.Payment
{
    public class CreatePaymentRequest
    {
        public string BookingId { get; set; }

        public string PaymentMethodId { get; set; }
    }
}