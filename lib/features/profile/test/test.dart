import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/features/profile/presentation/pages/my_profile.dart';


void main() {
  runApp(
    
    const ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProfileInfoScreen(),
      ),
    ),
  );
}