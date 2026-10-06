using Microsoft.AspNetCore.Mvc;
using Movie_Ticket_Booking_Backend.Domain.Movies;

[ApiController]
[Route("api/cinemas")]
public class CinemaController : ControllerBase
{
    private readonly ICinemaService _cinemaService;

    public CinemaController(ICinemaService cinemaService)
    {
        _cinemaService = cinemaService;
    }

    [HttpGet]
    public async Task<IActionResult> GetCinemas()
    {
        var userId = User.FindFirst("id")?.Value ?? User.FindFirst("UserId")?.Value;
        var cinemas = await _cinemaService.GetCinemas(userId);

        return Ok(cinemas);
    }

    [HttpGet("{cinemaId}")]
    public async Task<IActionResult> GetCinemaById(string cinemaId)
    {
        var userId = User.FindFirst("id")?.Value ?? User.FindFirst("UserId")?.Value;
        var cinema = await _cinemaService.GetCinemaById(cinemaId, userId);

        if (cinema == null)
            return NotFound();

        return Ok(cinema);
    }


    //[HttpGet("movies/{movieId}/cinemas")]
    //public async Task<IActionResult> GetCinemasByMovie(string movieId)
    //{
    //    var result = await _cinemaService.GetCinemasByMovie(movieId);
    //    return Ok(result);
    //}
    [HttpGet("{cinemaId}/movies")]
    public async Task<IActionResult> GetMoviesByCinema(string cinemaId)
    {
        var movies = await _cinemaService.GetMoviesByCinema(cinemaId);

        if (movies == null || !movies.Any())
            return NotFound(new { Message = "Không tìm thấy phim nào tại rạp này." });

        return Ok(movies);
    }
}