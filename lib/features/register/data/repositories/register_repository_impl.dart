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
}