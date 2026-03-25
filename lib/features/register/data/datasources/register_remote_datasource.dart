import 'package:movie_ticket_booking/core/network/dio_client.dart';
import '../models/register_request_model.dart';

class RegisterRemoteDataSource {
  final DioClient dioClient;

  RegisterRemoteDataSource(this.dioClient);

  Future<void> register(RegisterRequestModel model) async {
    await dioClient.dio.post("/api/users/register", data: model.toJson());
  }

  // Trong RegisterRemoteDatasource hoặc RegisterRepositoryImpl
  Future<bool> checkEmailExists(String email) async {
    try {
      final response = await dioClient.dio.get(
        '/api/auth/check-email',
        queryParameters: {'email': email},
      );
      // Trả về true/false dựa trên JSON { "exists": true/false } từ Backend
      return response.data['exists'] ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> sendOtp(String email) async {
    try {
      final response = await dioClient.dio.post(
        '/api/auth/send-otp',
        data: {'email': email},
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> verifyOtp(String email, String otp) async {
    final response = await dioClient.dio.post(
      '/api/auth/verify-otp',
      data: {'email': email, 'otp': otp},
    );
    return response.statusCode == 200;
  }
}
