import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../presentation/pages/notification_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: NotificationScreen(),
      ),
    ),
  );
}