import '../entities/notification_item.dart';

abstract class NotificationRepository {
  Future<List<AppNotification>> getNotifications();
}