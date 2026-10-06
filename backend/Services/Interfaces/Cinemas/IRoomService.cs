using Movie_Ticket_Booking_Backend.DTOs.Cinema;

namespace Movie_Ticket_Booking_Backend.Services.Interfaces.Cinemas
{
    public interface IRoomService
    {
        Task<List<RoomDto>> GetRoomsByCinema(string cinemaId);

        Task<RoomDto> CreateRoom(CreateRoomRequest request);

        Task<bool> DeleteRoom(string id);
    }
}
