using Microsoft.AspNetCore.Mvc;
using Movie_Ticket_Booking_Backend.Services.Interfaces.BlogPost;

namespace Movie_Ticket_Booking_Backend.Controllers.Blog
{
    [ApiController]
    [Route("api/[controller]")]
    public class CommentController : ControllerBase
    {
        private readonly ICommentService _commentService;

        public CommentController(ICommentService commentService)
        {
            _commentService = commentService;
        }

        // GET: api/1/comments
        [HttpGet("{blogPostId}/comments")]
        public async Task<IActionResult> GetComments(string blogPostId)
        {
            var result = await _commentService.GetCommentsByPostId(blogPostId);
            return Ok(result);
        }

        //// POST: api/comments
        //[HttpPost("comments")]
        //public async Task<IActionResult> CreateComment(CreateCommentRequest request)
        //{
        //    var userId = 1; // TODO: lấy từ JWT sau
        //    await _commentService.CreateComment(request, userId);

        //    return Ok();
        //}
    }
}
