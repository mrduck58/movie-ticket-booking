import '../data/models/register_request_model.dart';

abstract class RegisterRepository {
  Future<void> register(RegisterRequestModel model);
}