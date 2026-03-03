import 'app_error_type.dart';

class AppError implements Exception {
  final AppErrorType type;

  final int? statusCode;
  final String? code;

  final String message;

  final String? debugMessage;

  final Map<String, dynamic>? details;

  const AppError({
    required this.type,
    required this.message,
    this.statusCode,
    this.code,
    this.debugMessage,
    this.details,
  });

  @override
  String toString() {
    return 'AppError(type: $type, statusCode: $statusCode, code: $code, message: $message, debugMessage: $debugMessage, details: $details)';
  }

  AppError copyWith({
    AppErrorType? type,
    int? statusCode,
    String? code,
    String? message,
    String? debugMessage,
    Map<String, dynamic>? details,
  }) {
    return AppError(
      type: type ?? this.type,
      statusCode: statusCode ?? this.statusCode,
      code: code ?? this.code,
      message: message ?? this.message,
      debugMessage: debugMessage ?? this.debugMessage,
      details: details ?? this.details,
    );
  }
}