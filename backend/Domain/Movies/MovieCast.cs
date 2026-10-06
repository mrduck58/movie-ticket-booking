namespace Movie_Ticket_Booking_Backend.Domain.Movies
{
    public class MovieCast
    {
        public string MovieId { get; set; }
        public Movie Movie { get; set; }
        public string CastId { get; set; }
        public Cast Cast { get; set; }
        public string CharacterName { get; set; }
        public string CharacterAvatar { get; set; }

    }
}
