using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Ticket;

namespace Movie_Ticket_Booking_Backend.Controllers.Ticket
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]

    public class TicketController : ControllerBase
    {
        private readonly ITicketService _ticketService;

        public TicketController(ITicketService ticketService)
        {
            _ticketService = ticketService;
        }

        [HttpGet("mytickets")]
        public async Task<IActionResult> GetMyTickets()
        {
            var userId = User.FindFirst("UserId")?.Value;

            var result = await _ticketService.GetMyTickets(userId);

            return Ok(result);
        }
    }
}
