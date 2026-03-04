import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/features/seat_selection/presentation/pages/seat_selection_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SeatSelectionPage(showtimeId: 'st001',),
      ),
    ),
  );
}