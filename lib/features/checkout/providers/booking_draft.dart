import 'package:movie_ticket_booking/domain/entities/cinema.dart';
import 'package:movie_ticket_booking/domain/entities/combo.dart';
import 'package:movie_ticket_booking/domain/entities/seat.dart';
import 'package:movie_ticket_booking/domain/entities/showtime.dart';
import 'package:movie_ticket_booking/domain/entities/movie.dart';

class BookingDraft {
  final Movie? movie;
  final Cinema? cinema;
  final Showtime? showtime;
  final List<Seat> seats;
  final List<Combo>? combos;
  final String? paymentMethod;
  final String? date;
  final String? auditorium;
  final double? totalPrice;
  final String? package;

  BookingDraft({
    this.movie,
    this.cinema,
    this.showtime,
    this.seats = const [],
    this.combos = const [],
    this.paymentMethod,
    this.date,
    this.auditorium,
    this.totalPrice,
    this.package,

  });

  BookingDraft copyWith({
    Movie? movie,
    Cinema? cinema,
    Showtime? showtime,
    List<Seat>? seats,
    List<Combo>? combos,
    String? paymentMethod,
    String? date,
    String? auditorium,
    double? totalPrice,
    String? package,
  }) {
    return BookingDraft(
      movie: movie ?? this.movie,
      cinema: cinema ?? this.cinema,
      showtime: showtime ?? this.showtime,
      seats: seats ?? this.seats,
      combos: combos ?? this.combos,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      date: date ?? this.date,
      auditorium: auditorium ?? this.auditorium,
      totalPrice: totalPrice ?? this.totalPrice,
      package: package ?? this.package,
    );
  }
}