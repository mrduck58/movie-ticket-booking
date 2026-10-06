using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Movie_Ticket_Booking_Backend.DTOs.Blog;
using Movie_Ticket_Booking_Backend.Services.Implementations;
using Movie_Ticket_Booking_Backend.Services.Interfaces.BlogPost;

namespace Movie_Ticket_Booking_Backend.Controllers.Blog
{
    
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class BlogPostController : ControllerBase
    {
        private readonly IBlogService _blogService;
        private readonly ICommentService _commentService;

        public BlogPostController(IBlogService blogService, ICommentService commentService)
        {
            _blogService = blogService;
            _commentService = commentService;
        }

        [HttpGet("posts")]
        public async Task<IActionResult> GetPosts()
        {
            var userId = User.FindFirst("UserId")?.Value;
            var result = await _blogService.GetPostsAsync(userId);

            return Ok(result);
        }

        [HttpPost("{postId}/like")]
        public async Task<IActionResult> ToggleLike(string postId)
        {
            //var userId = "USR002";
            var userId = User.FindFirst("UserId")?.Value;
            var result = await _blogService.ToggleLikeAsync(postId, userId);

            if (result == null)
                return NotFound();

            return Ok(result);
        }
        [HttpPost]
        public async Task<IActionResult> CreatePost([FromBody] CreatePostRequestDto request)
        {
            //var userId = "USR002"; // 🔥 sau này lấy từ JWT
            var userId = User.FindFirst("UserId")?.Value;

            await _blogService.CreatePost(request, userId);

            return Ok(new { message = "Create post success" });
        }
        // Comments
        [HttpGet("{id}/comments")]
        public async Task<IActionResult> GetComments(string id)
        {
            var result = await _commentService.GetCommentsByPostId(id);
            return Ok(result);
        }
        [HttpPost("{id}/comments")]
        public async Task<IActionResult> CreateComment(string id, [FromBody] CreateCommentRequestDto request)
        {
            //var userId = "USR002";
            var userId = User.FindFirst("UserId")?.Value;

            await _commentService.CreateComment(id, request, userId);

            return Ok();
        }
    }
}
