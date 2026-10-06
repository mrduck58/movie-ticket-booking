using Microsoft.EntityFrameworkCore;
using Movie_Ticket_Booking_Backend.Data;
using Movie_Ticket_Booking_Backend.DTOs.Ticket;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Ticket;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Ticket;

namespace Movie_Ticket_Booking_Backend.Services.Implementations.Ticket
{
    public class TicketService : ITicketService
    {
        private readonly ITicketRepository _ticketRepository;
        private readonly AppDbContext _context;

        public TicketService(ITicketRepository ticketRepository, AppDbContext context)
        {
            _ticketRepository = ticketRepository;
            _context = context;
        }

        public async Task<List<TicketItemDto>> GetMyTickets(string userId)
        {
            var bookings = await _ticketRepository.GetBookingsByUserId(userId);

            var result = new List<TicketItemDto>();

            foreach (var booking in bookings)
            {
                var movie = booking.Showtime.Movie;

                var genres = await _context.MovieGenres
                    .Where(mg => mg.MovieId == movie.MovieId)
                    .Select(mg => mg.Genre.Name)
                    .ToListAsync();

                var poster = await _context.Posters
                    .Where(p => p.MovieId == movie.MovieId)
                    .Select(p => p.ImageUrl)
                    .FirstOrDefaultAsync();

                result.Add(new TicketItemDto
                {
                    Title = movie.Title,
                    Poster = poster,
                    StartTime = booking.Showtime.StartTime,
                    EndTime = booking.Showtime.EndTime,
                    Cinema = booking.Showtime.Room.Cinema.Name,
                    Room = booking.Showtime.Room.Name,
                    Seats = booking.BookingSeats
                        .Select(bs => bs.Seat.SeatName)
                        .OrderBy(s => s)
                        .ToList(),
                    Duration = movie.Duration,
                    Rating = movie.Rating,
                    Genres = genres,
                    QrDatas = booking.BookingSeats
                        .Select(bs => bs.QrCode)
                        .ToList()
                });
            }

            return result;
        }
    }
}
