import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../presentation/pages/intro_2.dart';

import '../presentation/pages/login_screen.dart';
import '../presentation/provider/login_provider.dart';
import '../data/repositories/login_repository_impl.dart';
import '../domain/repositories/login_repository.dart';
import '../data/datasources/login_mock_datasources.dart';

void main() {
  runApp(const LoginDevApp());
}

class LoginDevApp extends StatelessWidget {
  const LoginDevApp({super.key});

  @override
  Widget build(BuildContext context) {
    final datasource = LoginMockDatasource();
    final repository = LoginRepositoryImpl(datasource);

    return ProviderScope(
      overrides: [
        loginProvider.overrideWith((ref) {
          final datasource = LoginMockDatasource();
          final repository = LoginRepositoryImpl(datasource);
          return LoginProvider(repository);
        }),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Intro2(),
      ),
    );
  }
}
