import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/features/showtimes/presentation/pages/choose_showtime_page.dart';
import '../../../core/theme/app_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ChooseShowtimePage(cinemaId: 'amc_empire_25', movieId: 'm001',),
        
      ),
    ),
  );
}