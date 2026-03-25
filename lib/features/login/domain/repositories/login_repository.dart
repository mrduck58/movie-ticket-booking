abstract class LoginRepository {
  Future<String?> login(String email, String password);
  Future<String?> loginWithGoogle(String Token);
  Future<void> logout();
}