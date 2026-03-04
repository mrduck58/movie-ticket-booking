import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/features/login/presentation/pages/login_screen.dart';
import 'package:provider/provider.dart';
import '../data/datasources/login_local_datasources.dart';
import '../data/repository/login_repository.dart';
import '../presentation/provider/login_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(   
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => LoginProvider(
              LoginRepository(
                LoginLocalDatasources(),
              ),
            ),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}