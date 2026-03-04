import '../datasources/login_local_datasources.dart';

class LoginRepository {
  final LoginLocalDatasources localDatasources;
  LoginRepository(this.localDatasources);
  Future<bool> login(String email, String password) async {
    final accounts = await localDatasources.getAccounts();
    final user = accounts.where(
      (account) => account.email == email && account.password == password,
    );
    return user.isNotEmpty;
  }
}
