using Microsoft.EntityFrameworkCore;
using Movie_Ticket_Booking_Backend.Data;
using Movie_Ticket_Booking_Backend.Domain.Foods;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Foods;

namespace Movie_Ticket_Booking_Backend.Repositories.Implementations.Foods
{
    public class ComboRepository : IComboRepository
    {
        public readonly AppDbContext _context;
        public ComboRepository(AppDbContext context)
        {
            _context = context;
        }
        public async Task<List<FoodCombo>> GetAllComboAsync()
        {
            return await _context.FoodCombos.ToListAsync();
        }
    }
}
