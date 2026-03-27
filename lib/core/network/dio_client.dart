import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient({required String baseUrl, List<Interceptor>? interceptors})
      : dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            headers: {
              'ngrok-skip-browser-warning': 'true',
            },
          ),
        ) {
    if (interceptors != null) {
      dio.interceptors.addAll(interceptors);
    }
  }
}
