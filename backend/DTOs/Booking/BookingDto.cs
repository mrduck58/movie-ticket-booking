namespace Movie_Ticket_Booking_Backend.DTOs.Booking
{
    public class BookingDto
    {
        public string BookingId { get; set; }

        public string ShowtimeId { get; set; }

        public double TotalAmount { get; set; }

        public string Status { get; set; }

        public DateTime CreatedAt { get; set; }
        public List<BookingSeatDto> BookingSeats { get; set; } = new();
    }

    public class BookingSeatDto
    {
        public string SeatId { get; set; }
        public string SeatName { get; set; }
        public string QrCode { get; set; }
        public string Status { get; set; }
    }
}