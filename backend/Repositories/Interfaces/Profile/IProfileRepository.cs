using Movie_Ticket_Booking_Backend.Domain.Users;

namespace Movie_Ticket_Booking_Backend.Repositories.Interfaces.Profile
{
    public interface IProfileRepository
    {
        Task<User> GetById(string userId);
        Task Update(User user);
    }
}
