namespace Movie_Ticket_Booking_Backend.DTOs.Search
{
    public class SearchResultDto
    {
        public List<MovieSearchDto> Movies { get; set; }
        public List<CinemaSearchDto> Cinemas { get; set; }
    }
}
