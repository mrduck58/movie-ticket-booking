import '../../domain/entities/notification_item.dart';

class NotificationSection {
  final String title;
  final List<AppNotification> items;

  const NotificationSection({
    required this.title,
    required this.items,
  });
}