using Movie_Ticket_Booking_Backend.DTOs.Vouchers;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Vouchers;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Vouchers;

namespace Movie_Ticket_Booking_Backend.Services.Implementations.Vouchers
{
    public class VoucherService : IVoucherService
    {
        private readonly IVoucherRepository _repository;

        public VoucherService(IVoucherRepository repository)
        {
            _repository = repository;
        }

        public async Task<List<VoucherDto>> GetUserVouchers(string userId)
        {
            var userVouchers = await _repository.GetUserVouchers(userId);

            return userVouchers.Select(x => new VoucherDto
            {
                VoucherId = x.Voucher.VoucherId,
                Code = x.Voucher.Code,
                Title = x.Voucher.Title,
                Description = x.Voucher.Description,
                Type = x.Voucher.Type,
                Value = x.Voucher.Value,
                ExpiredDate = x.Voucher.ExpiredDate,
                Status = x.Status
            }).ToList();
        }

        public async Task ApplyVoucher(string userId, string voucherId)
        {
            var userVoucher = await _repository.GetUserVoucher(userId, voucherId);

            if (userVoucher == null)
                throw new Exception("Voucher not found");

            if (userVoucher.Status == "USED")
                throw new Exception("Voucher already used");

            if (userVoucher.Voucher.ExpiredDate < DateTime.UtcNow)
                throw new Exception("Voucher expired");

            userVoucher.Status = "USED";
            userVoucher.UsedAt = DateTime.UtcNow;

            await _repository.UpdateAsync(userVoucher);
        }
    }
}
