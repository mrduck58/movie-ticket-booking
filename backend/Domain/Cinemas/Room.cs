using Movie_Ticket_Booking_Backend.Domain.Showtimes;

namespace Movie_Ticket_Booking_Backend.Domain.Cinemas
{
    public class Room
    {
        public string RoomId { get; set; }
        public string Name { get; set; }
        public string CinemaId { get; set; }
        public Cinema Cinema { get; set; }

        public ICollection<Seat> Seats { get; set; }
        public ICollection<Showtime> Showtimes { get; set; }
    }
}
