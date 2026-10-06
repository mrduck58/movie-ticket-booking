using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Movie_Ticket_Booking_Backend.DTOs.Booking;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Payments;

[ApiController]
[Route("api/bookings")]
public class CheckoutController : ControllerBase
{
    private readonly IBookingService _bookingService;
    private readonly IBookingRepository _bookingRepository;
    private readonly IPayOSService _payOSService;
    private readonly ISeatLockRepository _seatLockRepository;

    public CheckoutController(
        IBookingService bookingService,
        IBookingRepository bookingRepository,
        IPayOSService payOSService,
        ISeatLockRepository seatLockRepository)
    {
        _bookingService = bookingService;
        _bookingRepository = bookingRepository;
        _payOSService = payOSService;
        _seatLockRepository = seatLockRepository;
    }

    // POST /api/bookings/checkout
    [HttpPost("checkout")]
    [Authorize]
    public async Task<IActionResult> Checkout([FromBody] CheckoutRequest request)
    {
        var userId = User.FindFirst("id")?.Value ?? User.FindFirst("UserId")?.Value;
        if (string.IsNullOrEmpty(userId))
            return Unauthorized();

        try
        {
            var (booking, checkoutUrl) = await _bookingService.CreateCheckout(userId, request);
            return Ok(new
            {
                orderCode = booking.OrderCode,
                checkoutUrl
            });
        }
        catch (Exception ex)
        {
            return BadRequest(new { message = ex.Message });
        }
    }

    // GET /api/bookings/{orderCode}/status
    // Hỏi thẳng PayOS để lấy trạng thái thật, cập nhật DB nếu cần → không cần ngrok
    [HttpGet("{orderCode}/status")]
    public async Task<IActionResult> GetPaymentStatus(long orderCode)
    {
        var booking = await _bookingRepository.GetBookingByOrderCode(orderCode);
        if (booking == null)
            return NotFound();

        // Nếu DB đã là PAID/CANCELLED thì trả về luôn
        if (booking.Status != "PENDING")
        {
            if (booking.Status == "BOOKED")
            {
                var bookingDto = await _bookingService.GetBooking(booking.BookingId);
                return Ok(bookingDto);
            }
            return Ok(new { status = booking.Status });
        }

        // Hỏi PayOS để biết trạng thái thực tế
        var payosStatus = await _payOSService.GetPaymentStatus(orderCode);

        if (payosStatus == "PAID")
        {
            // Cập nhật DB và xóa seat lock
            booking.Status = "BOOKED";
            foreach (var bs in booking.BookingSeats)
            {
                // Xóa lock tạm thời (lock 5p)
                await _seatLockRepository.RemoveLock(bs.SeatId, booking.ShowtimeId);

                // Tạo QrCode cho từng vé (ghế)
                bs.QrCode = $"TKT-{booking.BookingId}-{bs.SeatId}";
                bs.Status = "BOOKED"; 
            }
            await _bookingRepository.Save();
            await _seatLockRepository.Save();
        }
        else if (payosStatus == "CANCELLED" || payosStatus == "EXPIRED")
        {
            booking.Status = "CANCELLED";
            await _bookingRepository.Save();
        }

        // Return full DTO if BOOKED, else only status
        if (booking.Status == "BOOKED")
        {
            var bookingDto = await _bookingService.GetBooking(booking.BookingId);
            return Ok(bookingDto);
        }

        return Ok(new { status = booking.Status });
    }
}

