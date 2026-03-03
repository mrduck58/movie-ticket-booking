import 'app_error_type.dart';

class ErrorMessages {
  static String forType(AppErrorType type) {
    switch (type) {
      case AppErrorType.network:
        return 'Không có kết nối mạng. Vui lòng kiểm tra Wi-Fi/4G và thử lại.';
      case AppErrorType.timeout:
        return 'Kết nối quá lâu. Vui lòng thử lại sau.';
      case AppErrorType.cancelled:
        return 'Yêu cầu đã bị huỷ.';
      case AppErrorType.unauthorized:
        return 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.';
      case AppErrorType.forbidden:
        return 'Bạn không có quyền thực hiện thao tác này.';
      case AppErrorType.notFound:
        return 'Không tìm thấy dữ liệu.';
      case AppErrorType.conflict:
        return 'Dữ liệu đã thay đổi. Vui lòng tải lại và thử lại.';
      case AppErrorType.validation:
        return 'Dữ liệu không hợp lệ. Vui lòng kiểm tra lại.';
      case AppErrorType.rateLimited:
        return 'Bạn thao tác quá nhanh. Vui lòng chờ một chút rồi thử lại.';
      case AppErrorType.server:
        return 'Hệ thống đang bận. Vui lòng thử lại sau.';
      case AppErrorType.parse:
        return 'Có lỗi xử lý dữ liệu. Vui lòng cập nhật app hoặc thử lại.';
      case AppErrorType.unknown:
        return 'Đã xảy ra lỗi. Vui lòng thử lại.';
    }
  }
}