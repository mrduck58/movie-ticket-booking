using Movie_Ticket_Booking_Backend.DTOs.Movie;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Movies;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Movies;

namespace Movie_Ticket_Booking_Backend.Services.Implementations.Movies
{
    public class PosterService : IPosterService
    {
        private readonly IPosterRepository _posterRepository;
        public PosterService(IPosterRepository posterRepository)
        {
            _posterRepository = posterRepository;
        }
        public async Task<PosterDto?> GetPosterById(string id)
        {
            var poster = await _posterRepository.GetPosterById(id);
            if (poster == null) return null;
            return new PosterDto
            {
                PosterId = poster.PosterId,
                ImageUrl = poster.ImageUrl
            };
        }
        public async Task<List<PosterDto>> GetPostersByMovieId(string movieId)
        {
            var posters = await _posterRepository.GetPostersByMovieId(movieId);

            return posters.Select(p => new PosterDto
            {
                PosterId = p.PosterId,
                ImageUrl = p.ImageUrl
            }).ToList();
        }
    }
}
