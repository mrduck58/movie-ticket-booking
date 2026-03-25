import 'package:dio/dio.dart';

class LoginApiDatasource {
  final Dio dio;

  LoginApiDatasource(this.dio);

  Future<String?> login(String email, String password) async {
    final response = await dio.post(
      "/api/auth/login",
      data: {
        "email": email,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      return response.data["token"]; 
    }

    return null;
  }
  Future<String?> loginWithGoogle(String Token) async {
  try {
    // Gọi đến đúng endpoint api/auth/google-login
    final response = await dio.post('/api/auth/google-login', data: {
      'Token': Token,
    });

    if (response.statusCode == 200) {
      // Backend trả về { "token": "..." }
      return response.data['token'];
    }
    return null;
  } catch (e) {
    rethrow;
  }
}
}