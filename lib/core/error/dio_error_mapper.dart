import 'package:dio/dio.dart';

import 'app_error.dart';
import 'app_error_type.dart';
import 'error_messages.dart';

class DioErrorMapper {
  static AppError map(Object err, {String? fallbackMessage}) {
    if (err is AppError) return err;

    if (err is DioException) {
      // timeout / cancelled / network
      switch (err.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return AppError(
            type: AppErrorType.timeout,
            message: fallbackMessage ?? ErrorMessages.forType(AppErrorType.timeout),
            debugMessage: err.message,
          );

        case DioExceptionType.cancel:
          return AppError(
            type: AppErrorType.cancelled,
            message: fallbackMessage ?? ErrorMessages.forType(AppErrorType.cancelled),
            debugMessage: err.message,
          );

        case DioExceptionType.connectionError:
        case DioExceptionType.unknown:
          // thường là mất mạng/socket/dns
          // nhưng unknown cũng có thể do lỗi khác -> vẫn coi là network trước
          return AppError(
            type: AppErrorType.network,
            message: fallbackMessage ?? ErrorMessages.forType(AppErrorType.network),
            debugMessage: err.message,
          );

        case DioExceptionType.badResponse:
          final status = err.response?.statusCode;
          final data = err.response?.data;

          final mappedType = _mapStatusToType(status);
          final serverMessage = _tryExtractServerMessage(data);

          return AppError(
            type: mappedType,
            statusCode: status,
            message: serverMessage ??
                fallbackMessage ??
                ErrorMessages.forType(mappedType),
            debugMessage: err.message,
            details: _tryExtractDetails(data),
          );

        case DioExceptionType.badCertificate:
          return AppError(
            type: AppErrorType.network,
            message: fallbackMessage ?? ErrorMessages.forType(AppErrorType.network),
            debugMessage: 'Bad certificate: ${err.message}',
          );
      }
    }

    // parse/format common
    if (err is FormatException) {
      return AppError(
        type: AppErrorType.parse,
        message: fallbackMessage ?? ErrorMessages.forType(AppErrorType.parse),
        debugMessage: err.message,
      );
    }

    return AppError(
      type: AppErrorType.unknown,
      message: fallbackMessage ?? ErrorMessages.forType(AppErrorType.unknown),
      debugMessage: err.toString(),
    );
  }

  static AppErrorType _mapStatusToType(int? status) {
    if (status == null) return AppErrorType.unknown;
    if (status == 401) return AppErrorType.unauthorized;
    if (status == 403) return AppErrorType.forbidden;
    if (status == 404) return AppErrorType.notFound;
    if (status == 409) return AppErrorType.conflict;
    if (status == 422) return AppErrorType.validation;
    if (status == 429) return AppErrorType.rateLimited;
    if (status >= 500) return AppErrorType.server;
    return AppErrorType.unknown;
  }

  static String? _tryExtractServerMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      final msg1 = data['message'];
      if (msg1 is String && msg1.trim().isNotEmpty) return msg1;

      final err = data['error'];
      if (err is Map<String, dynamic>) {
        final msg2 = err['message'];
        if (msg2 is String && msg2.trim().isNotEmpty) return msg2;
      }
    }
    return null;
  }

  static Map<String, dynamic>? _tryExtractDetails(dynamic data) {
    if (data is Map<String, dynamic>) {
      final details = data['details'];
      if (details is Map<String, dynamic>) return details;
    }
    return null;
  }
}