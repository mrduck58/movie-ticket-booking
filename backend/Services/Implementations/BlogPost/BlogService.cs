 using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Hosting;
using Movie_Ticket_Booking_Backend.Domain.Blogs;
using Movie_Ticket_Booking_Backend.Domain.Notificaions;
using Movie_Ticket_Booking_Backend.DTOs.Blog;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.BlogPost;
using Movie_Ticket_Booking_Backend.Services.Interfaces.BlogPost;

namespace Movie_Ticket_Booking_Backend.Services.Implementations.BlogPost
{
    public class BlogService : IBlogService
    {
        private readonly IBlogRepository _blogRepository;

        public BlogService(IBlogRepository blogRepository)
        {
            _blogRepository = blogRepository;
        }
        
        public async Task<List<BlogPostFeedDto>> GetPostsAsync(String userId)
        {
            var posts = await _blogRepository.GetPostsAsync();
            //var currentUserId = "USR002";
            return posts.Select(p => new BlogPostFeedDto
            {
                Id = p.BlogPostId,
                Name = p.User.FullName,
                Avatar = p.User.AvatarUrl,
                CreatedAt = p.CreatedDate,
                Content = p.Content,
                Image = p.ImageUrl,
                Likes = p.Likes,
                IsLiked = p.PostLikes.Any(l => l.UserId == userId)
            }).ToList();
        }
        public async Task<ToggleLikeResponseDto?> ToggleLikeAsync(string postId, string userId)
        {
            var post = await _blogRepository.GetPostByIdAsync(postId);

            if (post == null)
                return null;

            var like = await _blogRepository.GetUserLikeAsync(postId, userId);

            bool isLiked;

            if (like != null)
            {
                await _blogRepository.RemoveLikeAsync(like);
                post.Likes -= 1;
                isLiked = false;
            }
            else
            {
                await _blogRepository.AddLikeAsync(new Domain.Blogs.PostLike
                {
                    PostLikeId = Guid.NewGuid().ToString(),
                    BlogPostId = postId,
                    UserId = userId,
                    CreatedAt = DateTime.UtcNow
                });

                post.Likes += 1;
                isLiked = true;

                // ✅ TẠO NOTIFICATION KHI LIKE
                if (post.UserId != userId) // tránh tự like tự notify
                {
                    var notification = new Notification
                    {
                        NotificationId = Guid.NewGuid().ToString(),
                        UserId = post.UserId, // người nhận thông báo
                        BlogPostId = postId,
                        Type = "LIKE_POST",
                        Message = "Your post has been liked",
                        IsRead = false,
                        CreatedAt = DateTime.UtcNow
                    };

                    await _blogRepository.AddAsync(notification);
                }
            }

            await _blogRepository.UpdatePostAsync(post);

            return new ToggleLikeResponseDto
            {
                Likes = post.Likes,
                IsLiked = isLiked
            };
        }
        public async Task CreatePost(CreatePostRequestDto request, string userId)
        {
            var post = new Domain.Blogs.BlogPost
            {
                BlogPostId = Guid.NewGuid().ToString(),
                UserId = userId,
                Title = "",
                Content = request.Content,
                ImageUrl = "",
                Likes = 0,
                CreatedDate = DateTime.Now
            };

            await _blogRepository.Create(post);
        }
    }

}
