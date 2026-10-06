namespace Movie_Ticket_Booking_Backend.DTOs.Booking
{
    public class CheckoutRequest
    {
        public string ShowtimeId { get; set; }

        /// <summary>
        /// Danh sách ghế kèm loại vé tương ứng.
        /// Flutter gửi: [ { "seatId": "S01", "showtimeTicketTypeId": "STT01" }, ... ]
        /// </summary>
        public List<SeatCheckoutItem> Seats { get; set; }

        public double ComboTotal { get; set; }
        public double TotalAmount { get; set; }
    }

    public class SeatCheckoutItem
    {
        public string SeatId { get; set; }
        public string ShowtimeTicketTypeId { get; set; }
    }
}
