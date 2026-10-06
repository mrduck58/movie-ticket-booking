namespace Movie_Ticket_Booking_Backend.DTOs.User
{
    public class RegisterUserRequest
    {
        public string Email { get; set; }

        public string Phone { get; set; }

        public string Password { get; set; }

        public string FullName { get; set; }

        public DateTime DateOfBirth { get; set; }

        public List<string> FavoriteGenres { get; set; }
    }
}
