using System.Globalization;
using Movie_Ticket_Booking_Backend.DTOs.User;
using Movie_Ticket_Booking_Backend.Repositories.Interfaces.Profile;
using Movie_Ticket_Booking_Backend.Services.Interfaces.Profile;
namespace Movie_Ticket_Booking_Backend.Services.Implementations.Profile
{
    public class ProfileService : IProfileService
    {
        private readonly IProfileRepository _profileRepository;

        public ProfileService(IProfileRepository profileRepository)
        {
            _profileRepository = profileRepository;
        }

        public async Task<UserProfileResponseDto> GetProfile(string userId)
        {
            var user = await _profileRepository.GetById(userId);

            if (user == null)
                throw new Exception("User not found");

            return new UserProfileResponseDto
            {
                Name = user.FullName,
                Gender = user.Gender,
                Email = user.Email,
                CCCD = user.CCCD,
                Address = user.Address,
                Hometown = user.Hometown,
                Birthday = user.DateOfBirth.ToString("dd/MM/yyyy")
            };
        }

        public async Task UpdateProfile(string userId, UserProfileResponseDto request)
        {
            var user = await _profileRepository.GetById(userId);

            if (user == null)
                throw new Exception("User not found");

            user.FullName = request.Name;
            user.Gender = request.Gender;
            user.Email = request.Email;
            user.CCCD = request.CCCD;
            user.Address = request.Address;
            user.Hometown = request.Hometown;

            if (!string.IsNullOrEmpty(request.Birthday))
            {
                var formats = new[] { "dd/MM/yyyy", "dd-MM-yyyy" };

                user.DateOfBirth = DateTime.ParseExact(
                    request.Birthday,
                    formats,
                    CultureInfo.InvariantCulture,
                    DateTimeStyles.None
                );
            }

            user.UpdatedAt = DateTime.Now;

            await _profileRepository.Update(user);
        }
    }
}
