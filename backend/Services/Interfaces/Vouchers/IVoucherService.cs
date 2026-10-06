using Movie_Ticket_Booking_Backend.DTOs.Vouchers;

namespace Movie_Ticket_Booking_Backend.Services.Interfaces.Vouchers
{
    public interface IVoucherService
    {
        Task<List<VoucherDto>> GetUserVouchers(string userId);

        Task ApplyVoucher(string userId, string voucherId);
    }
}
