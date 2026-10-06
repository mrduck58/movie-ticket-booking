using Microsoft.AspNetCore.Mvc;
using Movie_Ticket_Booking_Backend.DTOs.Booking;

[ApiController]
[Route("api/bookings")]
public class BookingController : ControllerBase
{
    private readonly IBookingService _bookingService;

    public BookingController(IBookingService bookingService)
    {
        _bookingService = bookingService;
    }

    [HttpPost("lock-seats")]
    public async Task<IActionResult> LockSeats(LockSeatRequest request)
    {
        var userId = User.FindFirst("id")?.Value ?? "mock-user";

        var success = await _bookingService.LockSeats(userId, request);

        if (!success)
            return BadRequest(new { message = "One or more seats are already booked or locked by another user." });

        return Ok(new { message = "Seats locked successfully for 5 minutes." });
    }

    [HttpPost]
    public async Task<IActionResult> CreateBooking(CreateBookingRequest request)
    {
        var userId = User.FindFirst("id")?.Value ?? "mock-user";

        try
        {
            var booking = await _bookingService.CreateBooking(userId, request);
            return Ok(booking);
        }
        catch (Exception ex)
        {
            return BadRequest(new { message = ex.Message });
        }
    }

    [HttpGet("{bookingId}")]
    public async Task<IActionResult> GetBooking(string bookingId)
    {
        var booking = await _bookingService.GetBooking(bookingId);

        if (booking == null)
            return NotFound();

        return Ok(booking);
    }

    [HttpGet("my-bookings")]
    public async Task<IActionResult> GetMyBookings()
    {
        var userId = User.FindFirst("id")?.Value;

        var bookings = await _bookingService.GetUserBookings(userId);

        return Ok(bookings);
    }

    [HttpPost("unlock-seats")]
    public async Task<IActionResult> UnlockSeats(LockSeatRequest request)
    {
        var userId = User.FindFirst("id")?.Value ?? "mock-user";

        await _bookingService.UnlockSeats(userId, request);

        return Ok(new { message = "Seats unlocked successfully." });
    }

    [HttpPost("{bookingId}/cancel")]
    public async Task<IActionResult> CancelBooking(string bookingId)
    {
        var userId = User.FindFirst("id")?.Value ?? "mock-user";

        var result = await _bookingService.CancelBooking(userId, bookingId);

        if (!result)
            return BadRequest(new { message = "Cannot cancel this booking. It might not be in PENDING status or you do not own it." });

        return Ok(new { message = "Booking cancelled successfully." });
    }
}