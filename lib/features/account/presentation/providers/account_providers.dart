import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/account_local_datasource.dart';
import '../../data/repositories/account_repository_impl.dart';
import '../../domain/repositories/account_repository.dart';
import 'account_controller.dart';
import 'account_state.dart';

final accountLocalDatasourceProvider =
    Provider((ref) => AccountLocalDatasource());

final accountRepositoryProvider =
    Provider<AccountRepository>((ref) {
  return AccountRepositoryImpl(
    ref.read(accountLocalDatasourceProvider),
  );
});

final accountControllerProvider =
    AsyncNotifierProvider<AccountController, AccountState>(
  AccountController.new,
);