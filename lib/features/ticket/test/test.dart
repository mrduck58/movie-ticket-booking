import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/features/ticket/presentation/pages/my_ticket.dart';


void main() {
  runApp(
    
    const ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyTicketsPage(),
      ),
    ),
  );
}