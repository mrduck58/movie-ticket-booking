using Movie_Ticket_Booking_Backend.DTOs.Foods;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Foods;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Foods;

namespace Movie_Ticket_Booking_Backend.Services.Implementations.Foods
{
    public class ComboService : IComboService
    {
        public readonly IComboRepository _comboRepository;
        public ComboService(IComboRepository comboRepository)
        {
            _comboRepository = comboRepository;
        }
        public async Task<List<FoodComboDto>> GetCombosAsync()
        {
            var combos = await _comboRepository.GetAllComboAsync();

            return combos.Select(c => new FoodComboDto
            {
                FoodComboId = c.FoodComboId,
                Name = c.Name,
                Description = c.Description,
                Price = c.Price,
                ImageUrl = c.ImageUrl
            }).ToList();
        }
    }
}
