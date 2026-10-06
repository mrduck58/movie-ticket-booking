using Movie_Ticket_Booking_Backend.Domain.Cinemas;

namespace Movie_Ticket_Booking_Backend.Repositories.Interfaces.Cinemas
{
    public interface IRoomRepository
    {
        Task<List<Room>> GetRoomsByCinema(string cinemaId);
        Task<Room?> GetRoom(string id);
        Task AddRoom(Room room);
        void DeleteRoom(Room room);
        Task Save();
    }
}
