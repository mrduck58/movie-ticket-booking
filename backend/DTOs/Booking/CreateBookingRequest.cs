namespace Movie_Ticket_Booking_Backend.DTOs.Booking
{
    public class CreateBookingRequest
    {
        public string ShowtimeId { get; set; }

        public List<string> SeatIds { get; set; }

        public List<FoodComboRequest>? Combos { get; set; }

        public string? VoucherCode { get; set; }
    }

    public class FoodComboRequest
    {
        public string FoodComboId { get; set; }

        public int Quantity { get; set; }
    }
}