using Movie_Ticket_Booking_Backend.DTOs.Payment;

namespace Movie_Ticket_Booking_Backend.Services.Interfaces.Payments
{
    public interface IPaymentMethodService
    {
        Task<List<PaymentMethodDto>> GetAll();

        Task<PaymentMethodDto> GetById(string id);

        Task Create(CreatePaymentMethodDto dto);

        Task Update(string id, UpdatePaymentMethodDto dto);

        Task Delete(string id);
    }
}
