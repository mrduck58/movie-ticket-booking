using Microsoft.EntityFrameworkCore;
using Movie_Ticket_Booking_Backend.Data;
using Movie_Ticket_Booking_Backend.Domain.Movies;
using Movie_Ticket_Booking_Backend.DTOs.Movie;
using Movie_Ticket_Booking_Backend.Repositories.Implementations.Movies;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Movies;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Movies;

public class MovieService : IMovieService
{
    private readonly IMovieRepository _movieRepository;
    private readonly IPosterRepository _posterRepository;
    private readonly IMovieCastRepository _movieCastRepository;
    private readonly IMovieGenreRepository _movieGenreRepository;

  
    private readonly AppDbContext _context;

    public MovieService(
        IMovieRepository movieRepository,
        IPosterRepository posterRepository,
        IMovieCastRepository movieCastRepository,
        IMovieGenreRepository movieGenreRepository,
        AppDbContext context) 
    {
        _movieRepository = movieRepository;
        _posterRepository = posterRepository;
        _movieCastRepository = movieCastRepository;
        _movieGenreRepository = movieGenreRepository;
        _context = context; 
    }

    public async Task<List<MovieDto>> GetMovies()
    {
        var movies = await _movieRepository.GetAllMovies();

        var result = new List<MovieDto>();

        foreach (var x in movies)
        {
            //  lấy poster theo từng movie
            var posters = await _posterRepository.GetPostersByMovieId(x.MovieId);
            var genres = await _movieGenreRepository.GetGenresByMovieId(x.MovieId);

            result.Add(new MovieDto
            {
                MovieId = x.MovieId,
                Title = x.Title,
                TitleVn = x.TitleVn,
                Duration = x.Duration,
                Rating = x.Rating,
                Status = x.Status,
                TrailerUrl = x.TrailerUrl,
                Director = x.Director,
                PosterUrl = posters.FirstOrDefault()?.ImageUrl,
                Genres = genres.Select(g => new GenreDto
                {
                    GenreId = g.GenreId,
                    Name = g.Genre.Name
                }).ToList()
            });
        }

        return result;
    }

    public async Task<MovieDto?> GetMovie(string id)
    {
        var movie = await _movieRepository.GetMovieById(id);

        if (movie == null) return null;

        var posters = await _posterRepository.GetPostersByMovieId(movie.MovieId);
        var casts = await _movieCastRepository.GetCastsByMovieId(movie.MovieId);
        var genres = await _movieGenreRepository.GetGenresByMovieId(movie.MovieId);

        var ratings = await _context.MovieRatings
            .Where(r => r.MovieId == id)
            .ToListAsync();

        var avgRating = ratings.Any() ? ratings.Average(r => r.Stars) : 0;
        var totalVotes = ratings.Count();

        return new MovieDto
        {
            MovieId = movie.MovieId,
            Title = movie.Title,
            TitleVn = movie.TitleVn,
            Duration = movie.Duration,


            Rating = Math.Round(avgRating, 1),
            TotalVotes = totalVotes,

            PosterUrl = posters.FirstOrDefault()?.ImageUrl,
            ReleaseDate = movie.CreatedAt,
            Director = movie.Director,
            Status = movie.Status,
            Description = movie.Description,
            TrailerUrl = movie.TrailerUrl,

            Casts = casts.Select(c => new CastDto
            {
                Name = c.Cast.Name,
                ImageUrl = c.Cast.AvatarUrl
            }).ToList(),

            Genres = genres.Select(g => new GenreDto
            {
                GenreId = g.GenreId,
                Name = g.Genre.Name
            }).ToList()
        };
    }

    public async Task<MovieDto> CreateMovie(CreateMovieRequest request)
    {
        var movie = new Movie
        {
            MovieId = Guid.NewGuid().ToString(),
            Title = request.Title,
            TitleVn = request.TitleVn,
            Description = request.Description,
            TrailerUrl = request.TrailerUrl,
            Director = request.Director,
            Duration = request.Duration,
            Rating = request.Rating,
            CreatedAt = DateTime.UtcNow,
            UpdatedAt = DateTime.UtcNow,
            Status = "ACTIVE"
        };

        await _movieRepository.AddMovie(movie);
        await _movieRepository.Save();

        return new MovieDto
        {
            MovieId = movie.MovieId,
            Title = movie.Title,
            TitleVn = movie.TitleVn,
            Duration = movie.Duration,
            Rating = movie.Rating,
            Description = movie.Description
        };
    }

    public async Task<bool> DeleteMovie(string id)
    {
        var movie = await _movieRepository.GetMovieById(id);

        if (movie == null) return false;

        _movieRepository.DeleteMovie(movie);
        await _movieRepository.Save();

        return true;
    }
}