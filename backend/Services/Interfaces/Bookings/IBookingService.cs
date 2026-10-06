using Movie_Ticket_Booking_Backend.DTOs.Booking;

public interface IBookingService
{
    Task<bool> LockSeats(string userId, LockSeatRequest request);
    Task<BookingDto> CreateBooking(string userId, CreateBookingRequest request);
    Task<(Movie_Ticket_Booking_Backend.Domain.Bookings.Booking booking, string checkoutUrl)> CreateCheckout(string userId, CheckoutRequest request);

    Task<BookingDto?> GetBooking(string bookingId);
    Task<List<BookingDto>> GetUserBookings(string userId);

    Task UnlockSeats(string userId, LockSeatRequest request);
    Task<bool> CancelBooking(string userId, string bookingId);
}