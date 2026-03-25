import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginApiDatasource {
  final Dio dio;

  LoginApiDatasource(this.dio);

  Future<String?> login(String email, String password) async {
    final response = await dio.post(
      "/api/auth/login",
      data: {"email": email, "password": password},
    );

    if (response.statusCode == 200) {
      final token = response.data["token"];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", token);

      return token;
    }

    return null;
  }

  Future<String?> loginWithGoogle(String Token) async {
    try {
      // Gọi đến đúng endpoint api/auth/google-login
      final response = await dio.post(
        '/api/auth/google-login',
        data: {'Token': Token},
      );

      if (response.statusCode == 200) {
        final jwt = response.data["token"];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", jwt);

        return jwt;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
