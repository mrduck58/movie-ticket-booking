namespace Movie_Ticket_Booking_Backend.Repositories.Interfaces.BlogPost;

using Movie_Ticket_Booking_Backend.Domain.Blogs;
using Movie_Ticket_Booking_Backend.Domain.Notificaions;

public interface IBlogRepository
{
    Task<List<BlogPost>> GetPostsAsync();
    Task<BlogPost?> GetPostByIdAsync(string postId);
    Task Create(BlogPost post);
    Task<PostLike?> GetUserLikeAsync(string postId, string userId);

    Task AddLikeAsync(PostLike like);

    Task RemoveLikeAsync(PostLike like);

    Task UpdatePostAsync(BlogPost post);
    Task AddAsync(Notification notification);
}
