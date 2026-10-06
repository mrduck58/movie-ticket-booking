using Movie_Ticket_Booking_Backend.DTOs.Search;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Search;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Search;

namespace Movie_Ticket_Booking_Backend.Services.Implementations.Search
{
    public class SearchService : ISearchService
    {
        private readonly ISearchRepository _repository;

        public SearchService(ISearchRepository repository)
        {
            _repository = repository;
        }

        public async Task<SearchResultDto> SearchAsync(string keyword)
        {
            var movies = await _repository.SearchMoviesAsync(keyword);
            var cinemas = await _repository.SearchCinemasAsync(keyword);

            return new SearchResultDto
            {
                Movies = movies.Select(m => new MovieSearchDto
                {
                    MovieId = m.MovieId,
                    Title = m.Title,
                    TitleVn = m.TitleVn,
                    PosterUrl = m.Posters.FirstOrDefault()?.ImageUrl ?? "",
                    Rating = m.Rating,
                    Duration = m.Duration,
                    Status = m.Status,
                    Director = m.Director
                }).ToList(),

                Cinemas = cinemas.Select(c => new CinemaSearchDto
                {
                    CinemaId = c.CinemaId,
                    Name = c.Name,
                    Location = c.Location,
                    Rating = c.Rating,
                    Hotline = c.Hotline
                }).ToList()
            };
        }
    }
}