using Movie_Ticket_Booking_Backend.DTOs.Blog;

namespace Movie_Ticket_Booking_Backend.Services.Interfaces.BlogPost
{
    public interface ICommentService
    {
        Task<List<CommentDto>> GetCommentsByPostId(string blogPostId);
        Task CreateComment(string blogPostId, CreateCommentRequestDto request, string userId);
    }
}
