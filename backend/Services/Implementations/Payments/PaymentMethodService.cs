using Movie_Ticket_Booking_Backend.Domain.Payments;
using Movie_Ticket_Booking_Backend.DTOs.Payment;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Payments;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Payments;

namespace Movie_Ticket_Booking_Backend.Services.Implementations.Payments
{
    public class PaymentMethodService : IPaymentMethodService
    {
        private readonly IPaymentMethodRepository _repo;

        public PaymentMethodService(IPaymentMethodRepository repo)
        {
            _repo = repo;
        }

        public async Task<List<PaymentMethodDto>> GetAll()
        {
            var methods = await _repo.GetAllAsync();

            return methods.Select(m => new PaymentMethodDto
            {
                PaymentMethodId = m.PaymentMethodId,
                Name = m.Name,
                ImageUrl = m.ImageUrl,
                Status = m.Status
            }).ToList();
        }

        public async Task<PaymentMethodDto> GetById(string id)
        {
            var method = await _repo.GetByIdAsync(id);

            if (method == null)
                throw new Exception("Payment method not found");

            return new PaymentMethodDto
            {
                PaymentMethodId = method.PaymentMethodId,
                Name = method.Name,
                ImageUrl = method.ImageUrl,
                Status = method.Status
            };
        }

        public async Task Create(CreatePaymentMethodDto dto)
        {
            var method = new PaymentMethod
            {
                PaymentMethodId = Guid.NewGuid().ToString(),
                Name = dto.Name,
                ImageUrl = dto.ImageUrl,
                Status = "ACTIVE",
                CreatedDate = DateTime.UtcNow,
                UpdatedDate = DateTime.UtcNow
            };

            await _repo.AddAsync(method);
            await _repo.SaveChangesAsync();
        }

        public async Task Update(string id, UpdatePaymentMethodDto dto)
        {
            var method = await _repo.GetByIdAsync(id);

            if (method == null)
                throw new Exception("Payment method not found");

            method.Name = dto.Name;
            method.ImageUrl = dto.ImageUrl;
            method.Status = dto.Status;
            method.UpdatedDate = DateTime.UtcNow;

            await _repo.SaveChangesAsync();
        }

        public async Task Delete(string id)
        {
            var method = await _repo.GetByIdAsync(id);

            if (method == null)
                throw new Exception("Payment method not found");

            await _repo.DeleteAsync(method);
            await _repo.SaveChangesAsync();
        }
    }
}
