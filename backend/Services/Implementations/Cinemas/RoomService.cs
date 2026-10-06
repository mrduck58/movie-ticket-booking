using Movie_Ticket_Booking_Backend.Domain.Cinemas;
using Movie_Ticket_Booking_Backend.DTOs.Cinema;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Cinemas;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Cinemas;

public class RoomService : IRoomService
{
    private readonly IRoomRepository _roomRepository;

    public RoomService(IRoomRepository roomRepository)
    {
        _roomRepository = roomRepository;
    }

    public async Task<List<RoomDto>> GetRoomsByCinema(string cinemaId)
    {
        var rooms = await _roomRepository.GetRoomsByCinema(cinemaId);

        return rooms.Select(x => new RoomDto
        {
            RoomId = x.RoomId,
            CinemaId = x.CinemaId,
            Name = x.Name
        }).ToList();
    }

    public async Task<RoomDto> CreateRoom(CreateRoomRequest request)
    {
        var room = new Room
        {
            CinemaId = request.CinemaId,
            Name = request.RoomName
        };

        await _roomRepository.AddRoom(room);

        await _roomRepository.Save();

        return new RoomDto
        {
            RoomId = room.RoomId,
            CinemaId = room.CinemaId,
            Name = room.Name
        };
    }

    public async Task<bool> DeleteRoom(string id)
    {
        var room = await _roomRepository.GetRoom(id);

        if (room == null)
            return false;

        _roomRepository.DeleteRoom(room);

        await _roomRepository.Save();

        return true;
    }
}