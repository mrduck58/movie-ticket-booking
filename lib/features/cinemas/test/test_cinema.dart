import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/features/cinemas/presentation/pages/choose_cinema_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ChooseCinemaPage(movieId: 'm001',),
      ),
    ),
  );
}