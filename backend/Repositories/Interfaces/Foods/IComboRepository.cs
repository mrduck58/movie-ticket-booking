using Movie_Ticket_Booking_Backend.Domain.Foods;
using static Azure.Core.HttpHeader;

namespace Movie_Ticket_Booking_Backend.Repositories.Interfaces.Foods
{
    public interface IComboRepository
    {
        Task<List<FoodCombo>> GetAllComboAsync();
    }
}
