import '../../domain/entities/notification_item.dart';

class AppNotificationModel extends AppNotification {
  const AppNotificationModel({
    required super.id,
    required super.message,
    required super.time,
    required super.isUnread,
    required super.type,
    super.relatedId,
  });

  factory AppNotificationModel.fromJson(Map<String, dynamic> json) {
    return AppNotificationModel(
      id: (json['notificationId'] ?? '').toString(),
      message: (json['message'] ?? '').toString(),
      time: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
      isUnread: !(json['isRead'] == true),
      type: NotificationType.fromString(json['type']?.toString()),
      relatedId: (json['relatedId'] ?? json['RelatedId'])?.toString(),
    );
  }
}