/// =======================================================
/// LẤY CHỮ CÁI ĐẦU TÊN USER
/// - Nếu name rỗng -> trả về 'U'
/// - Nếu có name -> lấy ký tự đầu, uppercase
///
/// Dùng cho avatar fallback khi không có ảnh.
/// =======================================================
String buildAccountInitial(String name) {
  final value = name.trim();
  if (value.isEmpty) return 'U';
  return value[0].toUpperCase();
}