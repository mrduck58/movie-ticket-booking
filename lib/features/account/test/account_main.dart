import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/features/account/presentation/pages/screens/account_screen.dart';

// import '../presentation/pages/account_screen.dart';
import '../../../../core/widgets/layouts/navigation_bar.dart';

void main() {
  runApp(
    const ProviderScope(
      child: TestApp(),
    ),
  );
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainLayout(
        child: AccountScreen(),
      ),
    );
  }
}