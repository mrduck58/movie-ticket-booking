using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Movie_Ticket_Booking_Backend.Data;
using Movie_Ticket_Booking_Backend.Domain.Movies;
using Movie_Ticket_Booking_Backend.DTOs.Movie;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Movies;

[ApiController]
[Route("api/movies")]
public class MovieController : ControllerBase
{
    private readonly IMovieService _movieService;
    private readonly ICinemaService _cinemaService;
    private readonly AppDbContext _context;

    public MovieController(IMovieService movieService, ICinemaService cinemaService,AppDbContext context )
    {
        _movieService = movieService;
        _cinemaService = cinemaService;
        _context = context;
    }

    [HttpGet]
    public async Task<IActionResult> GetMovies()
    {
        var movies = await _movieService.GetMovies();

        return Ok(movies);
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetMovie(string id)
    {
        var movie = await _movieService.GetMovie(id);

        if (movie == null)
            return NotFound();

        return Ok(movie);
    }

    [HttpGet("{movieId}/cinemas")]
    public async Task<IActionResult> GetCinemasByMovie(string movieId)
    {
        var result = await _cinemaService.GetCinemasByMovie(movieId);
        return Ok(result);
    }

    [HttpPost]
    public async Task<IActionResult> CreateMovie(CreateMovieRequest request)
    {
        var movie = await _movieService.CreateMovie(request);

        return Ok(movie);
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteMovie(string id)
    {
        var result = await _movieService.DeleteMovie(id);

        if (!result)
            return NotFound();

        return Ok();
    }
    [HttpPost("rate")]
    public async Task<IActionResult> RateMovie([FromBody] RateRequest request)
    {
        // ❗ check user
        var user = await _context.Users
            .FirstOrDefaultAsync(x => x.UserId == request.UserId);

        if (user == null)
            return BadRequest("User not found");

        // 🔥 check đã rate chưa
        var existing = await _context.MovieRatings
            .FirstOrDefaultAsync(x => x.MovieId == request.MovieId
                                  && x.UserId == request.UserId);

        if (existing != null)
        {
            existing.Stars = request.Stars; // update
        }
        else
        {
            var rating = new MovieRating
            {
                MovieRatingId = Guid.NewGuid().ToString(),
                MovieId = request.MovieId,
                UserId = request.UserId,
                Stars = request.Stars
            };

            _context.MovieRatings.Add(rating);
        }

        await _context.SaveChangesAsync();

        return Ok();
    }
}