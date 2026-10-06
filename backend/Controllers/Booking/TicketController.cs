using Microsoft.AspNetCore.Mvc;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Bookings;

[ApiController]
[Route("api/tickets")]
public class TicketController : ControllerBase
{
    private readonly ITicketService _ticketService;

    public TicketController(ITicketService ticketService)
    {
        _ticketService = ticketService;
    }

    [HttpPost("checkin/{bookingSeatId}")]
    public async Task<IActionResult> Checkin(string bookingSeatId)
    {
        var result = await _ticketService.Checkin(bookingSeatId);

        if (!result)
            return BadRequest();

        return Ok();
    }
}