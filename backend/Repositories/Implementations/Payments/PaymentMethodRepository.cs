using Movie_Ticket_Booking_Backend.Data;
using Movie_Ticket_Booking_Backend.Domain.Payments;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Payments;
using Microsoft.EntityFrameworkCore;

namespace Movie_Ticket_Booking_Backend.Repositories.Implementations.Payments
{
    public class PaymentMethodRepository : IPaymentMethodRepository
    {
        private readonly AppDbContext _context;

        public PaymentMethodRepository(AppDbContext context)
        {
            _context = context;
        }

        public async Task<List<PaymentMethod>> GetAllAsync()
        {
            return await _context.PaymentMethods.ToListAsync();
        }

        public async Task<PaymentMethod?> GetByIdAsync(string id)
        {
            return await _context.PaymentMethods
                .FirstOrDefaultAsync(p => p.PaymentMethodId == id);
        }

        public async Task AddAsync(PaymentMethod method)
        {
            await _context.PaymentMethods.AddAsync(method);
        }

        public async Task DeleteAsync(PaymentMethod method)
        {
            _context.PaymentMethods.Remove(method);
            await Task.CompletedTask;
        }

        public async Task SaveChangesAsync()
        {
            await _context.SaveChangesAsync();
        }
    }
}
