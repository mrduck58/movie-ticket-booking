using Microsoft.AspNetCore.Mvc;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Search;

namespace Movie_Ticket_Booking_Backend.Controllers.Search
{
    [ApiController]
    [Route("api/search")]
    public class SearchController : ControllerBase
    {
        private readonly ISearchService _service;

        public SearchController(ISearchService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<IActionResult> Search(string keyword)
        {
            if (string.IsNullOrWhiteSpace(keyword))
                return BadRequest(new { message = "Keyword is required" });

            var result = await _service.SearchAsync(keyword);

            if (!result.Movies.Any() && !result.Cinemas.Any())
                return NotFound(new { message = "No results found" });

            return Ok(result);
        }
    }
}
