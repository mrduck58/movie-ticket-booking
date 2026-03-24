import '../data/models/register_request_model.dart';

abstract class RegisterRepository {
  Future<void> register(RegisterRequestModel model);
  Future<bool> checkEmailExists(String email);
  Future<bool> sendOtp(String email);
  Future<bool> verifyOtp(String email, String otp);
}