using Microsoft.EntityFrameworkCore;
using Movie_Ticket_Booking_Backend.Data;
using Movie_Ticket_Booking_Backend.Domain.Bookings;

public class BookingRepository : IBookingRepository
{
    private readonly AppDbContext _context;

    public BookingRepository(AppDbContext context)
    {
        _context = context;
    }

    public async Task AddBooking(Booking booking)
    {
        await _context.Bookings.AddAsync(booking);
    }

    public async Task<Booking?> GetBooking(string bookingId)
    {
        return await _context.Bookings
            .Include(x => x.BookingSeats)
                .ThenInclude(bs => bs.Seat)
            .Include(x => x.BookingFoodCombos)
            .Include(x => x.BookingVouchers)
            .FirstOrDefaultAsync(x => x.BookingId == bookingId);
    }

    public async Task<Booking?> GetBookingByOrderCode(long orderCode)
    {
        return await _context.Bookings
            .Include(x => x.BookingSeats)
            .Include(x => x.Showtime)
                .ThenInclude(s => s.Movie)
            .FirstOrDefaultAsync(x => x.OrderCode == orderCode);
    }

    public async Task Save()
    {
        await _context.SaveChangesAsync();
    }
}