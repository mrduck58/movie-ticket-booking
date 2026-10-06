using Movie_Ticket_Booking_Backend.Services.Interfaces.Payments;

public class PaymentService : IPaymentService
{
    private readonly IBookingRepository _bookingRepository;

    public PaymentService(IBookingRepository bookingRepository)
    {
        _bookingRepository = bookingRepository;
    }

    public async Task<bool> Pay(string bookingId)
    {
        var booking = await _bookingRepository.GetBooking(bookingId);

        if (booking == null)
            return false;

        booking.Status = "PAID";

        await _bookingRepository.Save();

        return true;
    }
}