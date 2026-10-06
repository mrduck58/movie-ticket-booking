using Movie_Ticket_Booking_Backend.DTOs.Cinema;
using Movie_Ticket_Booking_Backend.DTOs.Seat;

public interface ISeatService
{
    Task<List<SeatDto>> GetSeatsByRoom(string roomId);

    Task<SeatMapDto> GetSeatMapAsync(string showtimeId, string? userId);

    Task<SeatDto> CreateSeat(CreateSeatRequest request);

    //Task<bool> LockSeat(string userId, LockSeatRequest request);

    //Task UnlockSeat(string seatId, string showtimeId);
}