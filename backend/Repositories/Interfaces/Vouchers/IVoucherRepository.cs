using Movie_Ticket_Booking_Backend.Domain.Vouchers;

namespace Movie_Ticket_Booking_Backend.Repositories.Interfaces.Vouchers
{
    public interface IVoucherRepository
    {
        Task<List<UserVoucher>> GetUserVouchers(string userId);
        Task<UserVoucher?> GetUserVoucher(string userId, string voucherId);
        Task UpdateAsync(UserVoucher userVoucher);
    }
}
