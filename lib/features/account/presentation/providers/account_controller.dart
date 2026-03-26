import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../domain/repositories/account_repository.dart';
import 'account_providers.dart';
import 'account_state.dart';
class AccountController extends AsyncNotifier<AccountState> {
  @override
  Future<AccountState> build() async {
    final repo = ref.read(accountRepositoryProvider);

    final user = await repo.getUser();

    return AccountState(user: user);
  }

  Future<void> refreshData() async {
    state = const AsyncLoading();
    state = AsyncData(await build());
  }
}