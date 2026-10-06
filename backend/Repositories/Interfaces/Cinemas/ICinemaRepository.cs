using Movie_Ticket_Booking_Backend.Domain.Cinemas;
using Movie_Ticket_Booking_Backend.Domain.Movies;

namespace Movie_Ticket_Booking_Backend.Repositories.Interfaces.Cinemas
{
    public interface ICinemaRepository
    {
        Task<List<Cinema>> GetCinemas();
        Task<Cinema?> GetCinemaById(string id);
        Task<List<Cinema>> GetCinemasByMovieId(string movieId);
        Task AddCinema(Cinema cinema);
        void UpdateCinema(Cinema cinema);
        void DeleteCinema(Cinema cinema);
        Task<List<Movie>> GetMoviesByCinemaId(string cinemaId);
        Task Save();

    }
}
