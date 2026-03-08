import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/features/post/presentation/pages/post_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() {
  runApp(
    
    const ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CommunityScreen(),
      ),
    ),
  );
}