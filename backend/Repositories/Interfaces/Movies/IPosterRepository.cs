using Movie_Ticket_Booking_Backend.Domain.Movies;

namespace Movie_Ticket_Booking_Backend.Repositories.Interfaces.Movies
{
    public interface IPosterRepository
    {
        Task<List<Poster>> GetPostersByMovieId(string movieId);
        Task<Poster?> GetPosterById(string id);
        //Task AddPoster(Poster poster);
        //void UpdatePoster(Poster poster);
        //void DeletePoster(Poster poster);
        Task Save();
    }
}
