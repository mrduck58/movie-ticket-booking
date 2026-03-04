import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/account_repository.dart';
import '../datasources/account_local_datasource.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountLocalDatasource local;

  AccountRepositoryImpl(this.local);

  @override
  Future<UserProfile> getUser() async {
    final user = await local.getUser();
    return user;
  }
}