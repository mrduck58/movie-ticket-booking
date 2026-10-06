using Microsoft.Extensions.Hosting;
using Movie_Ticket_Booking_Backend.Domain.Blogs;
using Movie_Ticket_Booking_Backend.Domain.Movies;
using Movie_Ticket_Booking_Backend.Domain.Notificaions;
using Movie_Ticket_Booking_Backend.DTOs.Blog;
using Movie_Ticket_Booking_Backend.Repositories.Implementations.BlogPost;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.BlogPost;
using Movie_Ticket_Booking_Backend.Services.Interfaces.BlogPost;

namespace Movie_Ticket_Booking_Backend.Services.Implementations.BlogPost
{
    public class CommentService : ICommentService
    {
        private readonly ICommentRepository _commentRepository;
        private readonly IBlogRepository _blogRepository;

        public CommentService(ICommentRepository commentRepository, IBlogRepository blogRepository)
        {
            _commentRepository = commentRepository;
            _blogRepository = blogRepository;
        }

        public async Task<List<CommentDto>> GetCommentsByPostId(string blogPostId)
        {
            return await _commentRepository.GetCommentsByPostId(blogPostId);
        }

        public async Task CreateComment(string blogPostId, CreateCommentRequestDto request, string userId)
        {
            var comment = new Comment
            {
                CommentId = Guid.NewGuid().ToString(),
                BlogPostId = blogPostId,
                UserId = userId,
                Content = request.Content,
                CreatedDate = DateTime.UtcNow
            };
            var post = await _blogRepository.GetPostByIdAsync(blogPostId);
            var notification = new Notification
            {
                NotificationId = Guid.NewGuid().ToString(),
                UserId = post.UserId, // người nhận thông báo
                BlogPostId = blogPostId,
                Type = "COMMENT_POST",
                Message = "Someone commented on your post",
                IsRead = false,
                CreatedAt = DateTime.UtcNow
            };

            await _blogRepository.AddAsync(notification);

            await _commentRepository.AddComment(comment);
        }
    }
}
