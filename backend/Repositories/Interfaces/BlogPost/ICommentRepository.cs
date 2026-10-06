using Movie_Ticket_Booking_Backend.Domain.Blogs;
using Movie_Ticket_Booking_Backend.DTOs.Blog;

namespace Movie_Ticket_Booking_Backend.Repositories.Interfaces.BlogPost
{
    public interface ICommentRepository
    {
        Task<List<CommentDto>> GetCommentsByPostId(string blogPostId);
        Task AddComment(Comment comment);
    }
}
