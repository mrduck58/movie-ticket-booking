using Microsoft.AspNetCore.Mvc;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Vouchers;

namespace Movie_Ticket_Booking_Backend.Controllers.Voucher
{
    [ApiController]
    [Route("api/vouchers")]

    public class VouchersController : ControllerBase
    {
        private readonly IVoucherService _voucherService;

        public VouchersController(IVoucherService voucherService)
        {
            _voucherService = voucherService;
        }

        [HttpGet("my")]
        public async Task<IActionResult> GetMyVouchers()
        {
            var userId = User.FindFirst("UserId")!.Value;

            var vouchers = await _voucherService.GetUserVouchers(userId);

            return Ok(vouchers);
        }

        [HttpPost("apply/{voucherId}")]
        public async Task<IActionResult> ApplyVoucher(string voucherId)
        {
            var userId = User.FindFirst("id")!.Value;

            await _voucherService.ApplyVoucher(userId, voucherId);

            return Ok();
        }
    }

}
