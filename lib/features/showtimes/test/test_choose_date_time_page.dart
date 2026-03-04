import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/features/showtimes/presentation/pages/choose_date_time_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ChooseDateTimePage(movieId: 'm001', cinemaId: 'c001'),
      ),
    ),
  );
}