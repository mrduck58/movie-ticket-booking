import 'package:dio/dio.dart';

class SimpleLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // ignore: avoid_print
    print('[DIO] => ${options.method} ${options.uri}');
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // ignore: avoid_print
    print('[DIO] ERROR => ${err.response?.statusCode} ${err.message}');
    handler.next(err);
  }
}