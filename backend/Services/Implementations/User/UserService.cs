using Google.Apis.Auth;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using Movie_Ticket_Booking_Backend.Data;
using Movie_Ticket_Booking_Backend.Domain.Movies;
using Movie_Ticket_Booking_Backend.Domain.Vouchers;
using Movie_Ticket_Booking_Backend.DTOs.User;
using System.Net.Http.Json;
using System.Security.Cryptography;
using System.Text;
namespace Movie_Ticket_Booking_Backend.Services.Implementations.User
{
    public class UserService
    {
        private readonly AppDbContext _context;
        private readonly JwtService _jwtService;
        private readonly IMemoryCache _cache;
        private readonly IEmailService _emailService;
        public UserService(AppDbContext context, JwtService jwtService, IMemoryCache cache, IEmailService emailService)
        {
            _context = context;
            _jwtService = jwtService;
            _cache = cache;
            _emailService = emailService;
        }
        private async Task GiveWelcomeVouchers(string userId)
        {
            var vouchers = new List<UserVoucher>
            {
                new UserVoucher { UserVoucherId = Guid.NewGuid().ToString(), UserId = userId, VoucherId = "VC001", Status = "AVAILABLE" },
                new UserVoucher { UserVoucherId = Guid.NewGuid().ToString(), UserId = userId, VoucherId = "VC002", Status = "AVAILABLE" },
                new UserVoucher { UserVoucherId = Guid.NewGuid().ToString(), UserId = userId, VoucherId = "VC003", Status = "AVAILABLE" },
                new UserVoucher { UserVoucherId = Guid.NewGuid().ToString(), UserId = userId, VoucherId = "VC004", Status = "AVAILABLE" },
                new UserVoucher { UserVoucherId = Guid.NewGuid().ToString(), UserId = userId, VoucherId = "VC005", Status = "AVAILABLE" }
            };

            _context.UserVouchers.AddRange(vouchers);
            await _context.SaveChangesAsync();
        }

        public async Task<Domain.Users.User> RegisterUser(RegisterUserRequest dto)
        {
            var userId = Guid.NewGuid().ToString();

            var user = new Domain.Users.User
            {
                UserId = userId,
                Email = dto.Email,
                Phone = dto.Phone,
                FullName = dto.FullName,
                DateOfBirth = dto.DateOfBirth,
                PasswordHash = HashPassword(dto.Password),
                AvatarUrl = "https://default-avatar.png",
                Status = "ACTIVE",
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now,
                RoleId = "ROLE002"
            };

            _context.Users.Add(user);

            if (dto.FavoriteGenres != null && dto.FavoriteGenres.Any())
            {
                var userGenres = dto.FavoriteGenres.Select(g => new UserGenre
                {
                    UserId = userId,
                    GenreId = g
                }).ToList();

                _context.UserGenres.AddRange(userGenres);
            }

            await _context.SaveChangesAsync();

            await GiveWelcomeVouchers(userId);

            return user;
        }

        private string HashPassword(string password)
        {
            using var sha256 = SHA256.Create();
            var bytes = Encoding.UTF8.GetBytes(password);
            var hash = sha256.ComputeHash(bytes);

            return Convert.ToBase64String(hash);
        }



        public async Task<string> LoginWithGoogle(string accessToken)
        {
            try
            {
                // 1. Dùng HttpClient gọi lên Google để lấy thông tin User từ AccessToken
                var client = new HttpClient();
                var response = await client.GetAsync($"https://www.googleapis.com/oauth2/v3/userinfo?access_token={accessToken}");

                if (!response.IsSuccessStatusCode)
                    return null;

                // 2. Đọc dữ liệu (Email, Name, Picture...)
                var payload = await response.Content.ReadFromJsonAsync<GoogleUserInfo>();
                if (payload == null || string.IsNullOrEmpty(payload.Email)) return null;

                // 3. Tìm hoặc tạo User (Giữ nguyên logic cũ của bạn)
                var user = await _context.Users
                    .Include(u => u.Role)
                    .FirstOrDefaultAsync(u => u.Email == payload.Email);

                if (user == null)
                {
                    user = new Domain.Users.User
                    {
                        UserId = Guid.NewGuid().ToString(),
                        Email = payload.Email,
                        FullName = payload.Name ?? "Google User",
                        AvatarUrl = payload.Picture ?? "https://default-avatar.png",
                        Phone = "0000000000",
                        DateOfBirth = new DateTime(2000, 1, 1),
                        PasswordHash = "SOCIAL_AUTH",
                        Status = "ACTIVE",
                        RoleId = "ROLE002",
                        CreatedAt = DateTime.Now,
                        UpdatedAt = DateTime.Now
                    };
                    _context.Users.Add(user);

                    await _context.SaveChangesAsync();

                    await GiveWelcomeVouchers(user.UserId);

                    // Nạp lại Role để tránh lỗi null khi tạo JWT
                    user = await _context.Users.Include(u => u.Role).FirstOrDefaultAsync(u => u.UserId == user.UserId);
                }

                return _jwtService.GenerateToken(user);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return null;
            }
        }
        public async Task<bool> IsEmailExists(string email)
        {
            return await _context.Users.AnyAsync(u => u.Email == email);
        }
        public async Task<bool> SendOtpAsync(string email)
        {
            // 1. Tạo mã 4 số ngẫu nhiên
            var otp = new Random().Next(1000, 9999).ToString();

            // 2. Lưu vào bộ nhớ tạm trong 5 phút
            _cache.Set(email, otp, TimeSpan.FromMinutes(5));

            // 3. Gửi Email
            string subject = "Xác nhận đăng ký VPHAN Booking";
            string message = $"Mã xác thực của bạn là: <b>{otp}</b>. Mã này có hiệu lực trong 5 phút.";

            try
            {
                await _emailService.SendEmailAsync(email, subject, message);
                return true;
            }
            catch { return false; }
        }
        public bool VerifyOtp(string email, string otp)
        {
            // Kiểm tra mã trong cache
            if (_cache.TryGetValue(email, out string storedOtp))
            {
                return storedOtp == otp;
            }
            return false;
        }

        public async Task<UserHeaderDto?> GetCurrentUser(string userId)
        {
            var user = await _context.Users
                .FirstOrDefaultAsync(x => x.UserId == userId);

            if (user == null) return null;

            return new UserHeaderDto
            {
                FullName = user.FullName,
                AvatarUrl = user.AvatarUrl
            };
        }

    }
}