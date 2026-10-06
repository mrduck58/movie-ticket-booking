using Microsoft.AspNetCore.Mvc;
using Movie_Ticket_Booking_Backend.DTOs.User;
using Movie_Ticket_Booking_Backend.Services.Implementations.User;

namespace Movie_Ticket_Booking_Backend.Controllers.User
{
    [ApiController]
    [Route("api/auth")]
    public class AuthController : ControllerBase
    {
        private readonly AuthService _authService;
        private readonly JwtService _jwtService;
        private readonly UserService _userService;

        public AuthController(AuthService authService, JwtService jwtService, UserService userService)
        {
            _authService = authService;
            _jwtService = jwtService;
            _userService = userService;
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login(LoginRequest request)
        {
            var user = await _authService.Login(request.Email, request.Password);

            if (user is null) 
                return Unauthorized("Invalid email or password");

            var token = _jwtService.GenerateToken(user);

            var response = new LoginResponse
            {
                Token = token,
                Email = user.Email,
                Role = user.Role.Name,
                UserId = user.UserId
            };

            return Ok(response);
        }

        [HttpPost("google-login")]
        public async Task<IActionResult> GoogleLogin([FromBody] GoogleLoginRequest request)
        {
            if (string.IsNullOrEmpty(request.Token))
                return BadRequest("Token không được để trống.");

            var token = await _userService.LoginWithGoogle(request.Token);

            if (token == null)
                return Unauthorized("Xác thực Google thất bại hoặc Token không hợp lệ.");

            return Ok(new { Token = token });
        }
        [HttpGet("check-email")]
        public async Task<IActionResult> CheckEmail([FromQuery] string email)
        {
            var exists = await _userService.IsEmailExists(email);
            return Ok(new { exists });
        }
        [HttpPost("send-otp")]
        public async Task<IActionResult> SendOtp([FromBody] SendOtpRequest request)
        {
            var success = await _userService.SendOtpAsync(request.Email);
            if (success) return Ok(new { message = "Mã OTP đã được gửi" });
            return BadRequest("Gửi mail thất bại.");
        }

        [HttpPost("verify-otp")]
        public IActionResult VerifyOtp([FromBody] VerifyOtpRequest request)
        {
            var isValid = _userService.VerifyOtp(request.Email, request.Otp);
            if (isValid) return Ok(new { message = "Xác thực thành công" });
            return BadRequest("Mã OTP không đúng hoặc đã hết hạn.");
        }
    }
}