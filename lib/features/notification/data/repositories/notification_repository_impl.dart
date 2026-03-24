import '../../domain/entities/notification_item.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_remote_datasource.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remote;

  NotificationRepositoryImpl(this.remote);

  @override
  Future<List<AppNotification>> getNotifications() async {
    return await remote.getNotifications();
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    await remote.markAsRead(notificationId);
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    await remote.deleteNotification(notificationId);
  }

  @override
  Future<void> clearAll() async {
    await remote.clearAll();
  }
}