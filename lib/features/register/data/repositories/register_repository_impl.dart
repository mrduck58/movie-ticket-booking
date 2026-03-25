import 'package:movie_ticket_booking/features/register/domain/register_repository.dart';
import '../datasources/register_remote_datasource.dart';
import '../models/register_request_model.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDataSource remote;

  RegisterRepositoryImpl(this.remote);

  @override
  Future<void> register(RegisterRequestModel model) {
    return remote.register(model);
  }
  @override
  Future<bool> checkEmailExists(String email) async {
    // Gọi đến hàm bạn đã viết trong datasource
    return await remote.checkEmailExists(email);
  }
  @override
  Future<bool> sendOtp(String email) async {
    return await remote.sendOtp(email);
  }

  @override
  Future<bool> verifyOtp(String email, String otp) async {
    return await remote.verifyOtp(email, otp);
  }
  
}