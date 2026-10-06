using Microsoft.AspNetCore.Mvc;
using Movie_Ticket_Booking_Backend.DTOs.Showtime;

[ApiController]
[Route("api/showtimes")]
public class ShowtimeController : ControllerBase
{
    private readonly IShowtimeService _showtimeService;
    private readonly ISeatService _seatService;

    public ShowtimeController(IShowtimeService showtimeService, ISeatService seatService)
    {
        _showtimeService = showtimeService;
        _seatService = seatService;
    }

    [HttpGet]
    public async Task<IActionResult> GetShowtimes(
    [FromQuery] string movieId,
    [FromQuery] string cinemaId,
    [FromQuery] DateTime date)
    {
        if (string.IsNullOrEmpty(movieId) || string.IsNullOrEmpty(cinemaId))
        {
            return BadRequest("movieId và cinemaId là bắt buộc");
        }

        var result = await _showtimeService
            .GetShowtimes(movieId, cinemaId, date);

        return Ok(result);
    }

    [HttpGet("{showtimeId}/seats")]
    public async Task<IActionResult> GetSeats(string showtimeId)
    {
        var userId = User.FindFirst("id")?.Value ?? User.FindFirst("UserId")?.Value;
        var result = await _seatService.GetSeatMapAsync(showtimeId, userId);

        return Ok(result);
    }

    public class LockSeatBody
    {
        public List<string> SeatIds { get; set; }
    }

    [HttpPost("{showtimeId}/lock-seats")]
    public async Task<IActionResult> LockSeats(string showtimeId, [FromBody] LockSeatBody body, [FromServices] IBookingService bookingService)
    {
        var userId = User.FindFirst("id")?.Value ?? User.FindFirst("UserId")?.Value ?? "mock-user";

        var lockRequest = new Movie_Ticket_Booking_Backend.DTOs.Booking.LockSeatRequest
        {
            ShowtimeId = showtimeId,
            SeatIds = body.SeatIds
        };

        var success = await bookingService.LockSeats(userId, lockRequest);

        if (!success)
            return BadRequest(new { message = "Ghế đã có người chọn" });

        return Ok(new { message = "Khóa ghế thành công" });
    }

    //[HttpGet("movie/{movieId}")]
    //public async Task<IActionResult> GetShowtimes(string movieId)
    //{
    //    var showtimes = await _showtimeService.GetShowtimesByMovie(movieId);

    //    return Ok(showtimes);
    //}

    //[HttpPost]
    //public async Task<IActionResult> CreateShowtime(CreateShowtimeRequest request)
    //{
    //    var showtime = await _showtimeService.CreateShowtime(request);

    //    return Ok(showtime);
    //}
}