using Microsoft.EntityFrameworkCore;
using Movie_Ticket_Booking_Backend.Data;
using Movie_Ticket_Booking_Backend.Domain.Bookings;
using Movie_Ticket_Booking_Backend.Domain.Cinemas;
using Movie_Ticket_Booking_Backend.DTOs.Booking;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Cinemas;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Payments;

public class BookingService : IBookingService
{
    private readonly IBookingRepository _bookingRepository;
    private readonly ISeatRepository _seatRepository;
    private readonly ISeatLockRepository _seatLockRepository;
    private readonly AppDbContext _context;
    private readonly IPayOSService _payOSService;

    public BookingService(
        AppDbContext context,
        IBookingRepository bookingRepository,
        ISeatRepository seatRepository,
        ISeatLockRepository seatLockRepository,
        IPayOSService payOSService)
    {
        _context = context;
        _bookingRepository = bookingRepository;
        _seatRepository = seatRepository;
        _seatLockRepository = seatLockRepository;
        _payOSService = payOSService;
    }

    public async Task<(Booking booking, string checkoutUrl)> CreateCheckout(string userId, CheckoutRequest request)
    {
        if (request.Seats == null || !request.Seats.Any())
            throw new Exception("Danh sách ghế không hợp lệ.");

        // Validate: các ghế phải đang bị lock bởi userId này
        foreach (var item in request.Seats)
        {
            var lock_ = await _seatLockRepository.GetActiveLock(item.SeatId, request.ShowtimeId);
            if (lock_ == null || lock_.UserId != userId)
                throw new Exception($"Ghế {item.SeatId} đã hết hạn giữ chỗ. Vui lòng chọn lại ghế.");
        }

        // Tạo OrderCode duy nhất từ timestamp (tối đa 9 chữ số theo chuẩn PayOS)
        var orderCode = long.Parse(DateTimeOffset.UtcNow.ToUnixTimeMilliseconds().ToString().Substring(4));

        var seatCount = request.Seats.Count;
        var pricePerSeat = (request.TotalAmount - request.ComboTotal) / seatCount;

        var booking = new Booking
        {
            BookingId = Guid.NewGuid().ToString(),
            UserId = userId,
            ShowtimeId = request.ShowtimeId,
            TotalAmount = request.TotalAmount,
            OrderCode = orderCode,
            Status = "PENDING",
            CreatedAt = DateTime.UtcNow,
            BookingSeats = request.Seats.Select(item => new BookingSeat
            {
                BookingSeatId = Guid.NewGuid().ToString(),
                BookingId = string.Empty, // set lại bên dưới
                SeatId = item.SeatId,
                ShowtimeTicketTypeId = item.ShowtimeTicketTypeId,
                Price = pricePerSeat,
                QrCode = Guid.NewGuid().ToString(),
                Status = "PENDING",
                CheckinTime = DateTime.UtcNow
            }).ToList(),
            BookingFoodCombos = new List<BookingFoodCombo>(),
            BookingVouchers = new List<BookingVoucher>()
        };

        foreach (var bs in booking.BookingSeats)
            bs.BookingId = booking.BookingId;

        await _bookingRepository.AddBooking(booking);
        await _bookingRepository.Save();

        // Gọi PayOS tạo link, expiredAt đồng bộ với SeatLock (CreatedAt + 5 phút)
        var checkoutUrl = await _payOSService.CreatePaymentLink(booking);

        return (booking, checkoutUrl);
    }

    public async Task<bool> LockSeats(string userId, LockSeatRequest request)
    {
        var bookedSeatIds = await _seatRepository.GetBookedSeatIdsAsync(request.ShowtimeId);
        
        foreach (var seatId in request.SeatIds)
        {
            if (bookedSeatIds.Contains(seatId))
            {
                return false;
            }

            var activeLock = await _seatLockRepository.GetActiveLock(seatId, request.ShowtimeId);
            if (activeLock != null && activeLock.UserId != userId)
            {
                return false;
            }
        }

        foreach (var seatId in request.SeatIds)
        {
            var activeLock = await _seatLockRepository.GetActiveLock(seatId, request.ShowtimeId);
            if (activeLock != null && activeLock.UserId == userId)
            {
                activeLock.ExpiredAt = DateTime.UtcNow.AddMinutes(5);
            }
            else
            {
                var newLock = new SeatLock
                {
                    SeatLockId = Guid.NewGuid().ToString(),
                    ShowtimeId = request.ShowtimeId,
                    SeatId = seatId,
                    UserId = userId,
                    LockedAt = DateTime.UtcNow,
                    ExpiredAt = DateTime.UtcNow.AddMinutes(5)
                };
                await _seatLockRepository.AddLock(newLock);
            }
        }

        await _seatLockRepository.Save();
        return true;
    }

    public async Task<BookingDto> CreateBooking(string userId, CreateBookingRequest request)
    {
        var booking = new Booking
        {
            BookingId = Guid.NewGuid().ToString(),
            UserId = userId,
            ShowtimeId = request.ShowtimeId,
            CreatedAt = DateTime.UtcNow,
            Status = "PENDING",
            BookingSeats = new List<BookingSeat>(),
            BookingFoodCombos = new List<BookingFoodCombo>(),
            BookingVouchers = new List<BookingVoucher>()
        };

        double total = 0;

        // 1️ Seats
        var bookedSeatIds = await _seatRepository.GetBookedSeatIdsAsync(request.ShowtimeId);

        foreach (var seatId in request.SeatIds)
        {
            if (bookedSeatIds.Contains(seatId))
                throw new Exception($"Seat {seatId} is already booked.");

            var activeLock = await _seatLockRepository.GetActiveLock(seatId, request.ShowtimeId);
            if (activeLock == null || activeLock.UserId != userId)
                throw new Exception($"Seat {seatId} lock has expired or is held by another user. Please select seats again.");

            var seat = await _seatRepository.GetSeat(seatId);

            if (seat == null)
                throw new Exception("Seat not found");

            var bookingSeat = new BookingSeat
            {
                BookingSeatId = Guid.NewGuid().ToString(),
                BookingId = booking.BookingId,
                SeatId = seatId,
                Price = 100000,
                QrCode = Guid.NewGuid().ToString(),
                Status = "BOOKED"
            };

            booking.BookingSeats.Add(bookingSeat);

            total += bookingSeat.Price;
        }

        // 2️ Food Combo
        if (request.Combos != null)
        {
            foreach (var combo in request.Combos)
            {
                var bookingCombo = new BookingFoodCombo
                {
                    BookingFoodComboId = Guid.NewGuid().ToString(),
                    BookingId = booking.BookingId,
                    FoodComboId = combo.FoodComboId,
                    Quantity = combo.Quantity
                };

                booking.BookingFoodCombos.Add(bookingCombo);

                total += 50000 * combo.Quantity;
            }
        }

        // 3️ Voucher
        if (!string.IsNullOrEmpty(request.VoucherCode))
        {
            var bookingVoucher = new BookingVoucher
            {
                BookingId = booking.BookingId,
                VoucherId = request.VoucherCode
            };

            booking.BookingVouchers.Add(bookingVoucher);

            total -= 20000;
        }

        booking.TotalAmount = total;

        await _bookingRepository.AddBooking(booking);

        await _bookingRepository.Save();

        foreach (var seatId in request.SeatIds)
        {
            await _seatLockRepository.RemoveLock(seatId, request.ShowtimeId);
        }
        await _seatLockRepository.Save();

        return new BookingDto
        {
            BookingId = booking.BookingId,
            ShowtimeId = booking.ShowtimeId,
            TotalAmount = booking.TotalAmount,
            Status = booking.Status,
            CreatedAt = booking.CreatedAt
        };
    }

    public async Task<BookingDto?> GetBooking(string bookingId)
    {
        var booking = await _bookingRepository.GetBooking(bookingId);

        if (booking == null)
            return null;

        return new BookingDto
        {
            BookingId = booking.BookingId,
            ShowtimeId = booking.ShowtimeId,
            TotalAmount = booking.TotalAmount,
            Status = booking.Status,
            CreatedAt = booking.CreatedAt,
            BookingSeats = booking.BookingSeats.Select(bs => new BookingSeatDto
            {
                SeatId = bs.SeatId,
                SeatName = bs.Seat?.SeatName ?? "Unknown",
                QrCode = bs.QrCode,
                Status = bs.Status
            }).ToList()
        };
    }

    public async Task<List<BookingDto>> GetUserBookings(string userId)
    {
        var bookings = await _context.Bookings
            .Include(x => x.Showtime)
            .Where(x => x.UserId == userId)
            .OrderByDescending(x => x.CreatedAt)
            .ToListAsync();

        return bookings.Select(x => new BookingDto
        {
            BookingId = x.BookingId,
            ShowtimeId = x.ShowtimeId,
            TotalAmount = x.TotalAmount,
            Status = x.Status,
            CreatedAt = x.CreatedAt
        }).ToList();
    }

    public async Task UnlockSeats(string userId, LockSeatRequest request)
    {
        foreach (var seatId in request.SeatIds)
        {
            var activeLock = await _seatLockRepository.GetActiveLock(seatId, request.ShowtimeId);
            if (activeLock != null && activeLock.UserId == userId)
            {
                await _seatLockRepository.RemoveLock(seatId, request.ShowtimeId);
            }
        }
        await _seatLockRepository.Save();
    }

    public async Task<bool> CancelBooking(string userId, string bookingId)
    {
        var booking = await _bookingRepository.GetBooking(bookingId);
        
        if (booking == null || booking.UserId != userId)
            return false;

        // Only allow cancelling PENDING bookings
        if (booking.Status != "PENDING")
            return false;

        booking.Status = "CANCELLED";

        foreach (var bs in booking.BookingSeats)
        {
            bs.Status = "CANCELLED";
        }

        await _bookingRepository.Save();

        return true;
    }
}