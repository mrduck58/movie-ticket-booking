using Movie_Ticket_Booking_Backend.Domain.Bookings;

namespace Movie_Ticket_Booking_Backend.Domain.Foods
{
    public class FoodCombo
    {
        public string FoodComboId { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Status { get; set; } = "ACTIVE";
        public double Price { get; set; }
        public string ImageUrl { get; set; }
        public DateTime CreatedDate { get; set; }
        public DateTime UpdatedDate { get; set; }

        public ICollection<BookingFoodCombo> BookingFoodCombos { get; set; }
    }
}
