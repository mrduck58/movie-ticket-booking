using Movie_Ticket_Booking_Backend.DTOs.Blog;

namespace Movie_Ticket_Booking_Backend.Services.Interfaces.BlogPost
{
    public interface IBlogService
    {
        Task<List<BlogPostFeedDto>> GetPostsAsync(String userId);
        Task<ToggleLikeResponseDto?> ToggleLikeAsync(string postId, string userId);
        Task CreatePost(CreatePostRequestDto request, string userId);
    }

}
