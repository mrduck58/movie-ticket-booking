using Movie_Ticket_Booking_Backend.DTOs.User;

namespace Movie_Ticket_Booking_Backend.Services.Interfaces.Profile
{
    public interface IProfileService
    {
        Task<UserProfileResponseDto> GetProfile(string userId);
        Task UpdateProfile(string userId, UserProfileResponseDto request);
    }
}
