using Movie_Ticket_Booking_Backend.DTOs.Search;

namespace Movie_Ticket_Booking_Backend.Services.Interfaces.Search
{
    public interface ISearchService
    {
        Task<SearchResultDto> SearchAsync(string keyword);
    }
}
