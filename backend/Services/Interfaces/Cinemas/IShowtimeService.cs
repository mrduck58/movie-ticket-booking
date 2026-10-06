using Movie_Ticket_Booking_Backend.DTOs.Showtime;

public interface IShowtimeService
{
    //Task<List<ShowtimeItemDto>> GetShowtimesByMovie(string movieId);
    Task<List<ShowtimeGroupDto>> GetShowtimes(string movieId, string cinemaId, DateTime date);
    //Task<ShowtimeItemDto> CreateShowtime(CreateShowtimeRequest request);
}