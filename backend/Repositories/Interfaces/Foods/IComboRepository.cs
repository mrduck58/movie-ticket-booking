using Movie_Ticket_Booking_Backend.Domain.Foods;

namespace Movie_Ticket_Booking_Backend.Repositories.Interfaces.Foods
{
    public interface IComboRepository
    {
        Task<List<FoodCombo>> GetAllComboAsync();
    }
}
