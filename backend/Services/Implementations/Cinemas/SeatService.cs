using Movie_Ticket_Booking_Backend.Domain.Cinemas;
using Movie_Ticket_Booking_Backend.DTOs.Cinema;
using Movie_Ticket_Booking_Backend.DTOs.Seat;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Cinemas;

public class SeatService : ISeatService
{
    private readonly ISeatRepository _seatRepository;
    private readonly IShowtimeRepository _showtimeRepository;

    public SeatService(ISeatRepository seatRepository, IShowtimeRepository showtimeRepository)
    {
        _seatRepository = seatRepository;
        _showtimeRepository = showtimeRepository;
    }

    public async Task<List<SeatDto>> GetSeatsByRoom(string roomId)
    {
        var seats = await _seatRepository.GetSeatsByRoom(roomId);

        return seats.Select(x => new SeatDto
        {
            SeatId = x.SeatId,
            SeatName = x.SeatName
        }).ToList();
    }

    public async Task<SeatMapDto> GetSeatMapAsync(string showtimeId, string? userId)
    {
        var showtime = await _showtimeRepository.GetShowtimeAsync(showtimeId);

        var seats = await _seatRepository.GetSeatsByRoomAsync(showtime.RoomId);

        var booked = await _seatRepository.GetBookedSeatIdsAsync(showtimeId);

        var activeLocks = await _seatRepository.GetActiveSeatLocksAsync(showtimeId);

        var seatDtos = seats.Select(seat =>
        {
            var status = "AVAILABLE";

            if (booked.Contains(seat.SeatId))
            {
                status = "BOOKED";
            }
            else
            {
                var lockRecord = activeLocks.FirstOrDefault(l => l.SeatId == seat.SeatId);
                if (lockRecord != null)
                {
                    if (userId != null && lockRecord.UserId == userId)
                    {
                        status = "SELECTED"; // Or LOCKED_BY_YOU
                    }
                    else
                    {
                        status = "LOCKED";
                    }
                }
            }

            var showtimeTicketTypeId = showtime.ShowtimeTicketTypes.FirstOrDefault()?.ShowtimeTicketTypeId;

            return new SeatDto
            {
                SeatId = seat.SeatId,
                SeatName = seat.SeatName,
                Status = status,
                ShowtimeTicketTypeId = showtimeTicketTypeId
            };

        }).ToList();

        return new SeatMapDto
        {
            ShowtimeId = showtimeId,
            RoomName = showtime.Room.Name,
            Seats = seatDtos
        };
    }

    //public async Task<SeatMapDto> GetSeatMapAsync(string showtimeId)
    //{
    //    var seats = await _seatRepository.GetSeatsByShowtimeAsync(showtimeId);

    //    var rows = seats
    //        .GroupBy(s => s.SeatName.Substring(0, 1))
    //        .Select(g => new SeatRowDto
    //        {
    //            RowName = g.Key,
    //            Seats = g.Select(s => new SeatDto
    //            {
    //                SeatId = s.SeatId,
    //                SeatName = s.SeatName,
    //                Status = s.Status
    //            }).OrderBy(x => x.SeatName).ToList()
    //        })
    //        .OrderBy(r => r.RowName)
    //        .ToList();

    //    return new SeatMapDto
    //    {
    //        ShowtimeId = showtimeId,
    //        RoomId = seats.First().RoomId,
    //        Rows = rows
    //    };
    //}

    public async Task<SeatDto> CreateSeat(CreateSeatRequest request)
    {
        var seat = new Seat
        {
            SeatId = Guid.NewGuid().ToString(),
            SeatName = request.SeatName,
            RoomId = request.RoomId
        };

        await _seatRepository.AddSeat(seat);
        await _seatRepository.Save();

        return new SeatDto
        {
            SeatId = seat.SeatId,
            SeatName = seat.SeatName
        };
    }

    //public async Task<bool> LockSeat(string userId, LockSeatRequest request)
    //{
    //    var seat = await _seatRepository.GetSeat(request.SeatId);

    //    if (seat == null)
    //        return false;

    //    seat.Status = "LOCKED";

    //    _seatRepository.UpdateSeat(seat);

    //    await _seatRepository.Save();

    //    return true;
    //}

    //public async Task UnlockSeat(string seatId, string showtimeId)
    //{
    //    var seat = await _seatRepository.GetSeat(seatId);

    //    if (seat != null)
    //    {
    //        seat.Status = "AVAILABLE";
    //        _seatRepository.UpdateSeat(seat);
    //        await _seatRepository.Save();
    //    }
    //}
}