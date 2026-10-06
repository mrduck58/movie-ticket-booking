using Movie_Ticket_Booking_Backend.Domain.Payments;

namespace Movie_Ticket_Booking_Backend.Repositories.Interfaces.Payments
{
    public interface IPaymentMethodRepository
    {
        Task<List<PaymentMethod>> GetAllAsync();

        Task<PaymentMethod?> GetByIdAsync(string id);

        Task AddAsync(PaymentMethod method);

        Task DeleteAsync(PaymentMethod method);

        Task SaveChangesAsync();
    }
}
