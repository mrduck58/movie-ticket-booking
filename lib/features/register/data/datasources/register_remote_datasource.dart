
import 'package:movie_ticket_booking/core/network/dio_client.dart';
import '../models/register_request_model.dart';

class RegisterRemoteDataSource {
  final DioClient dioClient;

  RegisterRemoteDataSource(this.dioClient);

  Future<void> register(RegisterRequestModel model) async {
    await dioClient.dio.post(
      "/api/users/register",
      data: model.toJson(),
    );
  }
}