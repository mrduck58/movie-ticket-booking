namespace Movie_Ticket_Booking_Backend.DTOs.Ticket
{
    public class TicketItemDto
    {
        public string Title { get; set; }
        public string Poster { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public string Cinema { get; set; }
        public string Room { get; set; }
        public List<string> Seats { get; set; }
        public double Duration { get; set; }
        public double Rating { get; set; }
        public List<string> Genres { get; set; }
        public List<string> QrDatas { get; set; }
    }
}
