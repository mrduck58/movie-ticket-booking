using Microsoft.AspNetCore.Mvc;
using Movie_Ticket_Booking_Backend.DTOs.Seat;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Cinemas;

[ApiController]
[Route("api/seat-lock")]
public class SeatLockController : ControllerBase
{
    private readonly ISeatLockService _seatLockService;

    public SeatLockController(ISeatLockService seatLockService)
    {
        _seatLockService = seatLockService;
    }

    [HttpPost]
    public async Task<IActionResult> LockSeat(LockSeatRequest request)
    {
        var userId = "mock-user";

        var result = await _seatLockService.LockSeat(userId, request);

        if (!result)
            return BadRequest("Seat already locked");

        return Ok();
    }
}