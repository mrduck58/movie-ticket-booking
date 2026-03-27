/// File cấu hình URL tập trung cho toàn bộ App.
/// Chỉ cần sửa ở đây khi đổi ngrok URL mới.
class AppConfig {
  // URL của backend (qua ngrok hoặc production)
  static const String baseUrl =
      'https://uncomplaisant-toothsomely-linette.ngrok-free.dev';

  static const String apiBaseUrl = '$baseUrl/api';
}
