using Movie_Ticket_Booking_Backend.DTOs.Notifications;

namespace Movie_Ticket_Booking_Backend.Services.Interfaces.Notifications
{
    public interface INotificationService
    {
        Task<List<NotificationDto>> GetUserNotifications(string userId);

        Task MarkAsRead(string userId, string notificationId);

        Task DeleteNotification(string userId, string notificationId);

        Task ClearAll(string userId);

        Task CreateNotification(CreateNotificationDto dto);
    }
}