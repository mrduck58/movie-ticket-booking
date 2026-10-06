using Movie_Ticket_Booking_Backend.Domain.Bookings;

public interface IBookingRepository
{
    Task AddBooking(Booking booking);

    Task<Booking?> GetBooking(string bookingId);

    Task<Booking?> GetBookingByOrderCode(long orderCode);

    Task Save();
}