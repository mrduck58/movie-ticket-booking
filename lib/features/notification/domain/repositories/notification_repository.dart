import '../entities/notification_item.dart';

abstract class NotificationRepository {
  Future<List<AppNotification>> getNotifications();
  Future<void> markAsRead(String notificationId);
  Future<void> deleteNotification(String notificationId);
  Future<void> clearAll();
}