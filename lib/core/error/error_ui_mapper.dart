import 'app_error.dart';
import 'app_error_type.dart';
import 'error_severity.dart';

class ErrorUiMapper {
  static ErrorSeverity severityOf(AppError error) {
    switch (error.type) {
      case AppErrorType.validation:
      case AppErrorType.unauthorized:
      case AppErrorType.forbidden:
      case AppErrorType.server:
      case AppErrorType.parse:
      case AppErrorType.unknown:
        return ErrorSeverity.error;

      case AppErrorType.network:
      case AppErrorType.timeout:
      case AppErrorType.rateLimited:
        return ErrorSeverity.warning;

      case AppErrorType.cancelled:
      case AppErrorType.notFound:
      case AppErrorType.conflict:
        return ErrorSeverity.info;
    }
  }

  //show nút thử lại
  static bool shouldShowRetry(AppError error) {
    switch (error.type) {
      case AppErrorType.network:
      case AppErrorType.timeout:
      case AppErrorType.server:
      case AppErrorType.rateLimited:
      case AppErrorType.unknown:
        return true;
      default:
        return false;
    }
  }

  static bool shouldLogout(AppError error) => error.type == AppErrorType.unauthorized;
}