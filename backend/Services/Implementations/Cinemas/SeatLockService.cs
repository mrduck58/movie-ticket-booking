using Movie_Ticket_Booking_Backend.Domain.Cinemas;
using Movie_Ticket_Booking_Backend.DTOs.Seat;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Cinemas;

public class SeatLockService : ISeatLockService
{
    private readonly ISeatLockRepository _seatLockRepository;

    public SeatLockService(ISeatLockRepository seatLockRepository)
    {
        _seatLockRepository = seatLockRepository;
    }

    public async Task<bool> LockSeat(string userId, LockSeatRequest request)
    {
        var existing = await _seatLockRepository
            .GetActiveLock(request.SeatId, request.ShowtimeId);

        if (existing != null)
            return false;

        var seatLock = new SeatLock
        {
            SeatLockId = Guid.NewGuid().ToString(),
            SeatId = request.SeatId,
            ShowtimeId = request.ShowtimeId,
            UserId = userId,
            LockedAt = DateTime.UtcNow,
            ExpiredAt = DateTime.UtcNow.AddMinutes(5)
        };

        await _seatLockRepository.AddLock(seatLock);

        await _seatLockRepository.Save();

        return true;
    }
}