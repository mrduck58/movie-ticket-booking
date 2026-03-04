import '../../domain/entities/notification_item.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_local_datasource.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationLocalDataSource local;

  NotificationRepositoryImpl(this.local);

  @override
  Future<List<AppNotification>> getNotifications() async {
    final list = await local.getNotifications();
    return List<AppNotification>.from(list);
  }
}