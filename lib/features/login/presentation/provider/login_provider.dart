import 'package:flutter_riverpod/legacy.dart';

import '../../data/datasources/login_mock_datasources.dart';
import '../../data/repositories/login_repository_impl.dart';
import '../../domain/repositories/login_repository.dart';

class LoginState {
  final bool isLoading;
  final String? token;
  final String? error;

  const LoginState({this.isLoading = false, this.token, this.error});

  LoginState copyWith({bool? isLoading, String? token, String? error}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      token: token ?? this.token,
      error: error,
    );
  }
}

class LoginProvider extends StateNotifier<LoginState> {
  final LoginRepository repository;

  LoginProvider(this.repository) : super(const LoginState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    final token = await repository.login(email, password);
     print("JWT TOKEN+++++++++: $token");

    if (token == null) {
      state = state.copyWith(
        isLoading: false,
        error: "Invalid email or password",
      );
      return;
    }

    state = state.copyWith(isLoading: false, token: token, error: null);
  }
}

final loginProvider = StateNotifierProvider<LoginProvider, LoginState>((ref) {
  final datasource = LoginMockDatasource();
  final repository = LoginRepositoryImpl(datasource);
  return LoginProvider(repository);
});
