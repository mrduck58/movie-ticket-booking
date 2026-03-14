import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../presentation/pages/intro_2.dart';
import '../presentation/provider/login_provider.dart';
import '../data/repositories/login_repository_impl.dart';


void main() {
  runApp(const LoginDevApp());
}

class LoginDevApp extends StatelessWidget {
  const LoginDevApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ProviderScope(
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Intro2(),
      ),
    );
  }
}
