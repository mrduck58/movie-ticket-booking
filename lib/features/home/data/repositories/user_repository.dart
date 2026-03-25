import '../datasources/user_api_datasource.dart';
import '../models/user_model.dart';

class UserRepository {
  final UserApiDatasource datasource;

  UserRepository(this.datasource);

  Future<UserModel> getCurrentUser() {
    return datasource.getCurrentUser();
  }
}