using Microsoft.AspNetCore.Mvc;
using Movie_Ticket_Booking_Backend.DTOs.Seat;

[ApiController]
[Route("api/seats")]
public class SeatController : ControllerBase
{
    private readonly ISeatService _seatService;

    public SeatController(ISeatService seatService)
    {
        _seatService = seatService;
    }

    [HttpGet("room/{roomId}")]
    public async Task<IActionResult> GetSeatsByRoom(string roomId)
    {
        var seats = await _seatService.GetSeatsByRoom(roomId);
        return Ok(seats);
    }

    [HttpGet("showtime/{showtimeId}")]
    public async Task<IActionResult> GetSeatMap(string showtimeId)
    {
        var userId = User.FindFirst("id")?.Value ?? User.FindFirst("UserId")?.Value;
        var seats = await _seatService.GetSeatMapAsync(showtimeId, userId);
        return Ok(seats);
    }

    [HttpPost]
    public async Task<IActionResult> CreateSeat(CreateSeatRequest request)
    {
        var seat = await _seatService.CreateSeat(request);
        return Ok(seat);
    }

    //[HttpPost("lock")]
    //public async Task<IActionResult> LockSeat(LockSeatRequest request)
    //{
    //    var userId = "mock-user";

    //    var result = await _seatService.LockSeat(userId, request);

    //    if (!result)
    //        return BadRequest();

    //    return Ok();
    //}

    //[HttpDelete("unlock")]
    //public async Task<IActionResult> UnlockSeat(string seatId, string showtimeId)
    //{
    //    await _seatService.UnlockSeat(seatId, showtimeId);

    //    return Ok();
    //}
}