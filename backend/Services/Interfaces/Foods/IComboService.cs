using Movie_Ticket_Booking_Backend.DTOs.Foods;

namespace Movie_Ticket_Booking_Backend.Services.Interfaces.Foods
{
    public interface IComboService
    {
        Task<List<FoodComboDto>> GetCombosAsync();
    }
}
