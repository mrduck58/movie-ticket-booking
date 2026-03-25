enum NotificationType {
  watchlistComingSoon,
  bookingSuccess,
  bookingReminder,
  comment,
  like,
  system,
  unknown;

  static NotificationType fromString(String? value) {
    switch ((value ?? '').toUpperCase()) {
      case 'WATCHLIST_COMING_SOON':
        return NotificationType.watchlistComingSoon;
      case 'BOOKING_SUCCESS':
        return NotificationType.bookingSuccess;
      case 'BOOKING_REMINDER':
        return NotificationType.bookingReminder;
      case 'COMMENT':
        return NotificationType.comment;
      case 'LIKE':
        return NotificationType.like;
      case 'SYSTEM':
        return NotificationType.system;
      default:
        return NotificationType.unknown;
    }
  }
}

class AppNotification {
  final String id;
  final String message;
  final DateTime time;
  final bool isUnread;
  final NotificationType type;

  const AppNotification({
    required this.id,
    required this.message,
    required this.time,
    required this.isUnread,
    required this.type,
  });

  AppNotification copyWith({
    String? id,
    String? message,
    DateTime? time,
    bool? isUnread,
    NotificationType? type,
  }) {
    return AppNotification(
      id: id ?? this.id,
      message: message ?? this.message,
      time: time ?? this.time,
      isUnread: isUnread ?? this.isUnread,
      type: type ?? this.type,
    );
  }
}