namespace Movie_Ticket_Booking_Backend.Repositories.Implementations.BlogPost;
using Microsoft.EntityFrameworkCore;
using Movie_Ticket_Booking_Backend.Data;
using Movie_Ticket_Booking_Backend.Domain.Blogs;
using Movie_Ticket_Booking_Backend.Domain.Notificaions;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.BlogPost;
using Repositories.Interfaces;

public class BlogRepository : IBlogRepository
{
    private readonly AppDbContext _context;

    public BlogRepository(AppDbContext context)
    {
        _context = context;
    }

    public async Task<List<BlogPost>> GetPostsAsync()
    {
        return await _context.BlogPosts
            .Include(p => p.User)
            .Include(p => p.PostLikes)
            .OrderByDescending(p => p.CreatedDate)
            .ToListAsync();
    }
    public async Task<BlogPost?> GetByIdAsync(string id)
    {
        return await _context.BlogPosts.FindAsync(id);
    }
    public async Task Create(BlogPost post)
    {
        await _context.BlogPosts.AddAsync(post);
        await _context.SaveChangesAsync();
    }

    public async Task UpdateAsync(BlogPost post)
    {
        _context.BlogPosts.Update(post);
        await _context.SaveChangesAsync();
    }

    public async Task<BlogPost?> GetPostByIdAsync(string postId)
    {
        return await _context.BlogPosts.FindAsync(postId);
    }

    public async Task<PostLike?> GetUserLikeAsync(string postId, string userId)
    {
        return await _context.PostLikes
            .FirstOrDefaultAsync(x => x.BlogPostId == postId && x.UserId == userId);
    }

    public async Task AddLikeAsync(PostLike like)
    {
        await _context.PostLikes.AddAsync(like);
    }

    public async Task RemoveLikeAsync(PostLike like)
    {
        _context.PostLikes.Remove(like);
    }

    public async Task UpdatePostAsync(BlogPost post)
    {
        _context.BlogPosts.Update(post);
        await _context.SaveChangesAsync();
    }

    public async Task AddAsync(Notification notification)
    {
        await _context.Notifications.AddAsync(notification);
        await _context.SaveChangesAsync();
    }
}
