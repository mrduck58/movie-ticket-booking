using Movie_Ticket_Booking_Backend.Domain.Foods;

namespace Movie_Ticket_Booking_Backend.Domain.Bookings
{
    public class BookingFoodCombo
    {
        public string BookingFoodComboId { get; set; }
        public string BookingId { get; set; }
        public Booking Booking { get; set; }
        public string FoodComboId { get; set; }
        public FoodCombo FoodCombo { get; set; }
        public int Quantity { get; set; }
    }
}
