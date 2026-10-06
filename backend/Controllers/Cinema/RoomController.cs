using Microsoft.AspNetCore.Mvc;
using Movie_Ticket_Booking_Backend.DTOs.Cinema;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Cinemas;

[ApiController]
[Route("api/rooms")]
public class RoomController : ControllerBase
{
    private readonly IRoomService _roomService;

    public RoomController(IRoomService roomService)
    {
        _roomService = roomService;
    }

    [HttpGet("cinema/{cinemaId}")]
    public async Task<IActionResult> GetRooms(string cinemaId)
    {
        var rooms = await _roomService.GetRoomsByCinema(cinemaId);

        return Ok(rooms);
    }

    [HttpPost]
    public async Task<IActionResult> CreateRoom(CreateRoomRequest request)
    {
        var room = await _roomService.CreateRoom(request);

        return Ok(room);
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteRoom(string id)
    {
        var result = await _roomService.DeleteRoom(id);

        if (!result)
            return NotFound();

        return Ok();
    }
}