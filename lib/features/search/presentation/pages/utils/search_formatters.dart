import 'package:flutter/material.dart';

import 'package:movie_ticket_booking/core/theme/app_colors.dart';

/// =======================================================
/// FORMAT DURATION CHO MOVIE SEARCH ITEM
/// - duration <= 0 -> '-'
/// - hợp lệ -> ví dụ '120m'
/// =======================================================
String formatMovieDuration(int duration) {
  if (duration <= 0) return '-';
  return '${duration}m';
}

/// =======================================================
/// MAP STATUS -> TEXT HIỂN THỊ
/// =======================================================
String movieStatusText(String status) {
  switch (status.toUpperCase()) {
    case 'NOWSHOWING':
      return 'Đang chiếu';
    case 'COMINGSOON':
      return 'Sắp chiếu';
    default:
      return status;
  }
}

/// =======================================================
/// MAP STATUS -> MÀU HIỂN THỊ
/// - NOWSHOWING -> success
/// - COMINGSOON -> orange
/// - default -> textSecondary
/// =======================================================
Color movieStatusColor(String status) {
  switch (status.toUpperCase()) {
    case 'NOWSHOWING':
      return AppColors.success;
    case 'COMINGSOON':
      return Colors.orange;
    default:
      return AppColors.textSecondary;
  }
}