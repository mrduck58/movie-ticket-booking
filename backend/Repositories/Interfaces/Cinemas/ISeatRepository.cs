using Movie_Ticket_Booking_Backend.Domain.Cinemas;

namespace Movie_Ticket_Booking_Backend.Repositories.Interfaces.Cinemas
{
    public interface ISeatRepository
    {
        Task<List<Seat>> GetSeatsByRoomAsync(string roomId);
        Task<List<string>> GetBookedSeatIdsAsync(string showtimeId);
        Task<List<string>> GetLockedSeatIdsAsync(string showtimeId);
        Task<List<SeatLock>> GetActiveSeatLocksAsync(string showtimeId);
        Task<List<Seat>> GetSeatsByRoom(string roomId);
        //Task<List<Seat>> GetSeatsByShowtimeAsync(string showtimeId);
        Task<Seat?> GetSeat(string seatId);
        Task AddSeat(Seat seat);
        void UpdateSeat(Seat seat);
        Task Save();
    }
}
