using Movie_Ticket_Booking_Backend.Domain.Movies;

namespace Movie_Ticket_Booking_Backend.Repositories.Interfaces.Movies
{
    public interface IGenreRepository
    {
        Task<List<Genre>> GetGenres();
        Task<Genre?> GetGenreById(string id);
        Task AddGenre(Genre genre);
        void UpdateGenre(Genre genre);
        void DeleteGenre(Genre genre);
        Task Save();
    }
}
