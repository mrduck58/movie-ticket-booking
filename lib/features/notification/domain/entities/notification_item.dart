enum LeadingType { circleIcon, poster }

class AppNotification {
  final String id;
  final LeadingType leadingType;
  final String? icon;
  final String? posterUrl;

  final String title;
  final String? subtitle;

  final DateTime time;
  final bool isUnread;
  final bool showChevron;

  const AppNotification({
    required this.id,
    required this.leadingType,
    required this.title,
    required this.time,
    this.subtitle,
    this.icon,
    this.posterUrl,
    this.isUnread = true,
    this.showChevron = false,
  });
}