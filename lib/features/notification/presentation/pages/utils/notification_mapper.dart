import 'package:flutter/material.dart';

import '../../../domain/entities/notification_item.dart';

/// =======================================================
/// MAP NotificationType -> TITLE HIỂN THỊ
/// =======================================================
String notificationTitleByType(AppNotification data) {
  switch (data.type) {
    case NotificationType.watchlistComingSoon:
      return 'Watchlist';
    case NotificationType.bookingSuccess:
      return 'Booking Success';
    case NotificationType.bookingReminder:
      return 'Booking Reminder';
    case NotificationType.comment:
      return 'Comment';
    case NotificationType.like:
      return 'Like';
    case NotificationType.system:
      return 'System';
    case NotificationType.unknown:
      return 'Notification';
  }
}

/// =======================================================
/// MAP NotificationType -> ICON HIỂN THỊ
/// =======================================================
IconData notificationIconByType(NotificationType type) {
  switch (type) {
    case NotificationType.bookingSuccess:
      return Icons.check_rounded;
    case NotificationType.bookingReminder:
      return Icons.access_time;
    case NotificationType.comment:
      return Icons.comment_outlined;
    case NotificationType.like:
      return Icons.favorite_border;
    case NotificationType.watchlistComingSoon:
      return Icons.movie_outlined;
    case NotificationType.system:
      return Icons.notifications_none;
    case NotificationType.unknown:
      return Icons.notifications_none;
  }
}