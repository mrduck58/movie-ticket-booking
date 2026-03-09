import 'package:movie_ticket_booking/domain/entities/showtime.dart';

class SelectedShowtime {
  final Showtime showtime;
  final String time;

  SelectedShowtime({
    required this.showtime,
    required this.time,
  });
}