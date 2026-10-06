using Movie_Ticket_Booking_Backend.Domain.Cinemas;
using Movie_Ticket_Booking_Backend.DTOs.Cinema;
using Movie_Ticket_Booking_Backend.DTOs.Movie;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Cinemas;


public class CinemaService : ICinemaService
{
    private readonly ICinemaRepository _cinemaRepository;
    private readonly IFavoriteCinemaRepository _favoriteRepository;

    public CinemaService(ICinemaRepository cinemaRepository, IFavoriteCinemaRepository favoriteRepository)
    {
        _cinemaRepository = cinemaRepository;
        _favoriteRepository = favoriteRepository;
    }

    public async Task<CinemaDto> CreateCinema(CreateCinemaRequest request)
    {
        var cinema = new Cinema
        {
            CinemaId = Guid.NewGuid().ToString(),
            Name = request.Name,
            Location = request.Location,
            Rating = request.Rating,
            Hotline = request.Hotline,
            CreatedAt = DateTime.UtcNow,
            UpdatedAt = DateTime.UtcNow
        };

        await _cinemaRepository.AddCinema(cinema);

        await _cinemaRepository.Save();

        return new CinemaDto
        {
            CinemaId = cinema.CinemaId,
            Name = cinema.Name,
            Location = cinema.Location,
            Rating = cinema.Rating,
            Hotline = cinema.Hotline
        };

    }

    public async Task<bool> DeleteCinema(string id)
    {
        var cinema = _cinemaRepository.GetCinemaById(id).Result;

        if (cinema == null) return false;

        _cinemaRepository.DeleteCinema(cinema);

        return true;
    }

    public async Task<CinemaDto?> GetCinemaById(string id, string? userId = null)
    {
        var cinema = await _cinemaRepository.GetCinemaById(id);
        if (cinema == null) return null;

        var isFavorite = false;
        if (!string.IsNullOrEmpty(userId))
        {
            var fav = await _favoriteRepository.GetFavorite(userId, id);
            isFavorite = fav != null;
        }

        return new CinemaDto
        {
            CinemaId = cinema.CinemaId,
            Name = cinema.Name,
            Location = cinema.Location,
            Rating = cinema.Rating,
            Hotline = cinema.Hotline,
            IsFavorite = isFavorite
        };
    }

    public async Task<List<CinemaDto>> GetCinemas(string? userId = null)
    {
        var cinemas = await _cinemaRepository.GetCinemas();
        var favorites = new HashSet<string>();

        if (!string.IsNullOrEmpty(userId))
        {
            var favList = await _favoriteRepository.GetFavoriteCinemas(userId);
            favorites = favList.Select(f => f.CinemaId).ToHashSet();
        }

        return cinemas.Select(x => new CinemaDto
        {
            CinemaId = x.CinemaId,
            Name = x.Name,
            Location = x.Location,
            Rating = x.Rating,
            Hotline = x.Hotline,
            IsFavorite = favorites.Contains(x.CinemaId)
        }).ToList();
    }

    public async Task<List<CinemaListDto>> GetCinemasByMovie(string movieId)
    {
        var cinemas = await _cinemaRepository.GetCinemasByMovieId(movieId);

        return cinemas.Select(c => new CinemaListDto
        {
            CinemaId = c.CinemaId,
            Name = c.Name,
            Location = c.Location
        }).ToList();
    }
    public async Task<List<MovieDto>> GetMoviesByCinema(string cinemaId)
    {
        var movies = await _cinemaRepository.GetMoviesByCinemaId(cinemaId);

        return movies.Select(m => new MovieDto
        {
            MovieId = m.MovieId,
            Title = m.Title,
            TitleVn = m.TitleVn,
            Duration = m.Duration,
            Rating = m.Rating,
            Director = m.Director,
            PosterUrl = m.Posters.FirstOrDefault()?.ImageUrl ?? "https://via.placeholder.com/300",
            TrailerUrl = m.TrailerUrl,
            Status = m.Status,
            Description = m.Description,
            // Nếu Movie entity có Casts/Genres thì map tiếp vào đây
        }).ToList();
    }
}