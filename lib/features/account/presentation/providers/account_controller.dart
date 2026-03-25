import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/account_repository.dart';
import 'account_providers.dart';
import 'account_state.dart';

class AccountController extends AsyncNotifier<AccountState> {
  late final AccountRepository _repo;

  @override
  Future<AccountState> build() async {
    _repo = ref.read(accountRepositoryProvider);

    final user = await _repo.getUser();

    return AccountState(user: user);
  }

  Future<void> refreshData() async {
    state = const AsyncLoading();
    state = AsyncData(await build());
  }
}