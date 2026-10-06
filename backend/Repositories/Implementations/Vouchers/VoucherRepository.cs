using Microsoft.EntityFrameworkCore;
using Movie_Ticket_Booking_Backend.Data;
using Movie_Ticket_Booking_Backend.Domain.Vouchers;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Vouchers;

namespace Movie_Ticket_Booking_Backend.Repositories.Implementations.Vouchers
{
    public class VoucherRepository : IVoucherRepository
    {
        private readonly AppDbContext _context;
        public VoucherRepository(AppDbContext context)
        {
            _context = context;
        }
        public async Task<List<UserVoucher>> GetUserVouchers(string userId)
        {
            return await _context.UserVouchers
                .Include(x => x.Voucher)
                .Where(x => x.UserId == userId)
                .ToListAsync();
        }

        public async Task<UserVoucher?> GetUserVoucher(string userId, string voucherId)
        {
            return await _context.UserVouchers
                .Include(x => x.Voucher)
                .FirstOrDefaultAsync(x => x.UserId == userId && x.VoucherId == voucherId);
        }

        public async Task UpdateAsync(UserVoucher userVoucher)
        {
            _context.UserVouchers.Update(userVoucher);
            await _context.SaveChangesAsync();
        }
    }
}
