using Microsoft.EntityFrameworkCore;
using Movie_Ticket_Booking_Backend.Data;
using Movie_Ticket_Booking_Backend.Domain.Users;
using System.Security.Cryptography;
using System.Text;

namespace Movie_Ticket_Booking_Backend.Services.Implementations.User
{
    public class AuthService
    {
        private readonly AppDbContext _context;

        public AuthService(AppDbContext context)
        {
            _context = context;
        }

        public async Task<Domain.Users.User?> Login(string email, string password)
        {
            var user = await _context.Users
                .Include(x => x.Role)
                .FirstOrDefaultAsync(x => x.Email == email);

            if (user == null)
                return null;

            // 👉 HASH password người dùng nhập
            var hashedInputPassword = HashPassword(password);

            // 👉 so hash với hash
            if (user.PasswordHash != hashedInputPassword)
                return null;

            return user;
        }
        private string HashPassword(string password)
        {
            using var sha256 = SHA256.Create();
            var bytes = Encoding.UTF8.GetBytes(password);
            var hash = sha256.ComputeHash(bytes);

            return Convert.ToBase64String(hash);
        }
    }
}