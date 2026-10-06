using Movie_Ticket_Booking_Backend.Domain.Showtimes;
using Movie_Ticket_Booking_Backend.DTOs.Showtime;

public class ShowtimeService : IShowtimeService
{
    private readonly IShowtimeRepository _showtimeRepository;

    public ShowtimeService(IShowtimeRepository showtimeRepository)
    {
        _showtimeRepository = showtimeRepository;
    }

    public async Task<List<ShowtimeGroupDto>> GetShowtimes(
        string movieId,
        string cinemaId,
        DateTime date)
    {
        var showtimes = await _showtimeRepository
            .GetByMovieCinemaDate(movieId, cinemaId, date);

        return showtimes
            .SelectMany(s => s.ShowtimeTicketTypes, (s, st) => new
            {
                s.ShowtimeId,
                s.StartTime,
                RoomName = s.Room.Name,
                TicketType = st.TicketType.Name,
                Price = st.Price
            })
            .GroupBy(x => x.TicketType)
            .Select(g => new ShowtimeGroupDto
            {
                TicketType = g.Key,
                Price = g.First().Price,
                Showtimes = g.Select(x => new ShowtimeItemDto
                {
                    ShowtimeId = x.ShowtimeId,
                    StartTime = x.StartTime,
                    RoomName = x.RoomName
                }).ToList()
            })
            .ToList();
    }

    //public async Task<List<ShowtimeItemDto>> GetShowtimesByMovie(string movieId)
    //{
    //    var showtimes = await _showtimeRepository.GetShowtimesByMovie(movieId);

    //    return showtimes.Select(x => new ShowtimeDto
    //    {
    //        ShowtimeId = x.ShowtimeId,
    //        MovieId = x.MovieId,
    //        RoomId = x.RoomId,
    //        StartTime = x.StartTime,
    //        EndTime = x.EndTime
    //    }).ToList();
    //}

    //public async Task<ShowtimeItemDto> CreateShowtime(CreateShowtimeRequest request)
    //{
    //    var showtime = new Showtime
    //    {
    //        MovieId = request.MovieId,
    //        RoomId = request.RoomId,
    //        StartTime = request.StartTime,
    //        EndTime = request.EndTime
    //    };

    //    await _showtimeRepository.AddShowtime(showtime);

    //    await _showtimeRepository.Save();

    //    return new ShowtimeItemDto
    //    {
    //        ShowtimeId = showtime.ShowtimeId,
    //        MovieId = showtime.MovieId,
    //        RoomId = showtime.RoomId,
    //        StartTime = showtime.StartTime,
    //        EndTime = showtime.EndTime
    //    };
    //}
}