using Microsoft.EntityFrameworkCore;
using Movie_Ticket_Booking_Backend.Data;
using Movie_Ticket_Booking_Backend.Domain.Blogs;
using Movie_Ticket_Booking_Backend.DTOs.Blog;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.BlogPost;

namespace Movie_Ticket_Booking_Backend.Repositories.Implementations.BlogPost
{
    public class CommentRepository : ICommentRepository
    {
        private readonly AppDbContext _context;

        public CommentRepository(AppDbContext context)
        {
            _context = context;
        }

        public async Task<List<CommentDto>> GetCommentsByPostId(string blogPostId)
        {
            return await _context.Comments
                .Where(c => c.BlogPostId == blogPostId)
                .Include(c => c.User)
                .OrderByDescending(c => c.CreatedDate)
                .Select(c => new CommentDto
                {
                    Id = c.CommentId,
                    Name = c.User.FullName,
                    Avatar = c.User.AvatarUrl,
                    Content = c.Content
                })
                .ToListAsync();
        }

        public async Task AddComment(Comment comment)
        {
            _context.Comments.Add(comment);
            await _context.SaveChangesAsync();
        }
    }
}
