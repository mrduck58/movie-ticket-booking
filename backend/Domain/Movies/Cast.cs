namespace Movie_Ticket_Booking_Backend.Domain.Movies
{
    public class Cast
    {
        public string CastId { get; set; }
        public string Name { get; set; }
        public string AvatarUrl { get; set; }

        public ICollection<MovieCast> MovieCasts { get; set; }
    }
}
