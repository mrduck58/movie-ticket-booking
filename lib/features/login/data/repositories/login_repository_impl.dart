import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import '../datasources/login_mock_datasources.dart';
import '../../domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginMockDatasource datasource;

  LoginRepositoryImpl(this.datasource);

  @override
  Future<String?> login(String email, String password) async {
    final accounts = await datasource.getAccounts();

    final user = accounts.firstWhere(
      (acc) => acc['email'] == email && acc['password'] == password,
      orElse: () => {},
    );

    if (user.isEmpty) {
      return null;
    }
    final token = _generateFakeJwt();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);

    return token;
  }

  String _generateFakeJwt() {
    final random = Random();

    String randomString(int length) {
      const chars =
          'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

      return List.generate(
        length,
        (index) => chars[random.nextInt(chars.length)],
      ).join();
    }

    final header = base64Url
        .encode(utf8.encode('{"alg":"HS256","typ":"JWT"}'))
        .replaceAll('=', '');

    final payload = base64Url
        .encode(
          utf8.encode(
            jsonEncode({
              "user": "mock",
              "iat": DateTime.now().millisecondsSinceEpoch,
            }),
          ),
        )
        .replaceAll('=', '');

    final signature = randomString(32);

    return "$header.$payload.$signature";
  }
}
