/// =======================================================
/// FORMAT DURATION
/// - minutes null hoặc <= 0 -> trả về '-'
/// - hợp lệ -> ví dụ '120 min'
///
/// Tách ra utils để:
/// - widget gọn hơn
/// - logic format không bị lặp
/// - dễ đổi format sau này
/// =======================================================
String formatDuration(int? minutes) {
  if (minutes == null || minutes <= 0) return '-';
  return '$minutes min';
}

/// =======================================================
/// FORMAT RATING
/// - rating null hoặc <= 0 -> 'N/A'
/// - hợp lệ -> convert sang string
///
/// Có thể nâng cấp sau này:
/// - fixed 1 decimal
/// - bỏ số 0 dư
/// =======================================================
String formatRating(double? rating) {
  if (rating == null || rating <= 0) return 'N/A';
  return rating.toString();
}