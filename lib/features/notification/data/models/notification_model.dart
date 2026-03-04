import '../../domain/entities/notification_item.dart';

class AppNotificationModel extends AppNotification {
  AppNotificationModel({
    required super.id,
    required super.leadingType,
    required super.title,
    required super.time,
    super.subtitle,
    super.icon,
    super.posterUrl,
    super.isUnread,
    super.showChevron,
  });

  static LeadingType _parseType(String raw) {
    switch (raw) {
      case 'poster':
        return LeadingType.poster;
      default:
        return LeadingType.circleIcon;
    }
  }

  factory AppNotificationModel.fromJson(Map<String, dynamic> json) {
    return AppNotificationModel(
      id: json['id'],
      leadingType: _parseType(json['leadingType']),
      icon: json['icon'],
      posterUrl: json['posterUrl'],
      title: json['title'],
      subtitle: json['subtitle'],
      time: DateTime.parse(json['time']),
      isUnread: json['isUnread'] ?? true,
      showChevron: json['showChevron'] ?? false,
    );
  }
}