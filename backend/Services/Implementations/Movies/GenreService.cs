using Movie_Ticket_Booking_Backend.Domain.Movies;
using Movie_Ticket_Booking_Backend.DTOs.Movie;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Movies;

public class GenreService : IGenreService
{
    private readonly IGenreRepository _genreRepository;

    public GenreService(IGenreRepository genreRepository)
    {
        _genreRepository = genreRepository;
    }

    public async Task<List<GenreDto>> GetGenres()
    {
        var genres = await _genreRepository.GetGenres();

        return genres.Select(x => new GenreDto
        {
            GenreId = x.GenreId,
            Name = x.Name
        }).ToList();
    }

    public async Task<GenreDto> CreateGenre(CreateGenreRequest request)
    {
        var genre = new Genre
        {
            GenreId = Guid.NewGuid().ToString(),
            Name = request.Name,
            CreatedAt = DateTime.UtcNow,
            UpdatedAt = DateTime.UtcNow,
        };

        await _genreRepository.AddGenre(genre);

        await _genreRepository.Save();

        return new GenreDto
        {
            GenreId = genre.GenreId,
            Name = genre.Name
        };
    }

    public async Task<bool> DeleteGenre(string id)
    {
        var genre = await _genreRepository.GetGenreById(id);

        if (genre == null) return false;

        _genreRepository.DeleteGenre(genre);

        await _genreRepository.Save();

        return true;
    }
}