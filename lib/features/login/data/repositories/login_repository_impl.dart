import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_api_datasources.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginApiDatasource datasource;

  LoginRepositoryImpl(this.datasource);

  @override
  Future<String?> login(String email, String password) async {
    final token = await datasource.login(email, password);

    if (token == null) return null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);

    return token;
  }

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
  }
}
