import 'showtime.dart';

class ShowtimeGroup {
  final String ticketType;
  final double price;
  final List<Showtime> showtimes;

  ShowtimeGroup({
    required this.ticketType,
    required this.price,
    required this.showtimes,
  });
}