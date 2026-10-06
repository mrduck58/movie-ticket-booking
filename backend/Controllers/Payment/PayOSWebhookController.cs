using Microsoft.AspNetCore.Mvc;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Cinemas;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Payments;
using System.IO;
using System.Text;

[ApiController]
[Route("api/payos")]
public class PayOSWebhookController : ControllerBase
{
    private readonly IPayOSService _payOSService;
    private readonly IBookingRepository _bookingRepository;
    private readonly ISeatLockRepository _seatLockRepository;

    public PayOSWebhookController(
        IPayOSService payOSService,
        IBookingRepository bookingRepository,
        ISeatLockRepository seatLockRepository)
    {
        _payOSService = payOSService;
        _bookingRepository = bookingRepository;
        _seatLockRepository = seatLockRepository;
    }

    // POST /api/payos/webhook
    [HttpPost("webhook")]
    public async Task<IActionResult> Webhook()
    {
        using var reader = new StreamReader(Request.Body, Encoding.UTF8);
        var body = await reader.ReadToEndAsync();

        // Xác thực chữ ký và lấy orderCode nếu giao dịch thành công
        var orderCode = await _payOSService.GetVerifiedOrderCode(body);

        if (orderCode.HasValue)
        {
            var booking = await _bookingRepository.GetBookingByOrderCode(orderCode.Value);
            if (booking != null && booking.Status == "PENDING")
            {
                booking.Status = "PAID";

                // Giải phóng lock ghế vĩnh viễn sau khi thanh toán thành công
                foreach (var bs in booking.BookingSeats)
                {
                    await _seatLockRepository.RemoveLock(bs.SeatId, booking.ShowtimeId);
                }

                await _bookingRepository.Save();
                await _seatLockRepository.Save();
            }
        }

        return Ok(new { success = true });
    }

    // GET /api/payos/callback/success
    [HttpGet("callback/success")]
    public async Task<IActionResult> PaymentSuccess([FromQuery] long orderCode)
    {
        var booking = await _bookingRepository.GetBookingByOrderCode(orderCode);
        if (booking != null && booking.Status == "PENDING")
        {
            booking.Status = "PAID";
            foreach (var bs in booking.BookingSeats)
            {
                await _seatLockRepository.RemoveLock(bs.SeatId, booking.ShowtimeId);
            }
            await _bookingRepository.Save();
            await _seatLockRepository.Save();
        }
        
        var html = $@"
            <html>
            <head>
                <meta name='viewport' content='width=device-width, initial-scale=1.0'>
                <style>
                    body {{ font-family: sans-serif; text-align: center; padding-top: 50px; background: #1a1a1a; color: white; }}
                    .btn {{ display: inline-block; padding: 12px 24px; background: #e50914; color: white; text-decoration: none; border-radius: 25px; margin-top: 20px; font-weight: bold; }}
                </style>
            </head>
            <body onload=""window.location='movieticket://payment-success?orderCode={orderCode}'"">
                <div style='font-size: 60px;'>✅</div>
                <h2>Thanh toán thành công!</h2>
                <p>Đang quay lại ứng dụng Movie Ticket...</p>
                <a href='movieticket://payment-success?orderCode={orderCode}' class='btn'>Mở App Ngay</a>
                <script>
                    setTimeout(function() {{
                        window.location = 'movieticket://payment-success?orderCode={orderCode}';
                    }}, 2000);
                </script>
            </body>
            </html>";
        return Content(html, "text/html");
    }

    // GET /api/payos/callback/cancel
    [HttpGet("callback/cancel")]
    public async Task<IActionResult> PaymentCancel([FromQuery] long orderCode)
    {
        var booking = await _bookingRepository.GetBookingByOrderCode(orderCode);
        if (booking != null && booking.Status == "PENDING")
        {
            booking.Status = "CANCELLED";
            await _bookingRepository.Save();
        }

        var html = $@"
            <html>
            <head>
                <meta name='viewport' content='width=device-width, initial-scale=1.0'>
                <style>
                    body {{ font-family: sans-serif; text-align: center; padding-top: 50px; background: #1a1a1a; color: white; }}
                    .btn {{ display: inline-block; padding: 12px 24px; border: 2px solid #e50914; color: #e50914; text-decoration: none; border-radius: 25px; margin-top: 20px; font-weight: bold; }}
                </style>
            </head>
            <body onload=""window.location='movieticket://payment-cancel'"">
                <div style='font-size: 60px;'>❌</div>
                <h2>Đã hủy thanh toán</h2>
                <p>Đang quay lại ứng dụng Movie Ticket...</p>
                <a href='movieticket://payment-cancel' class='btn'>Quay lại App</a>
                <script>
                    setTimeout(function() {{
                        window.location = 'movieticket://payment-cancel';
                    }}, 2000);
                </script>
            </body>
            </html>";
        return Content(html, "text/html");
    }
}
