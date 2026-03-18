import 'package:movie_ticket_booking/domain/entities/cinema.dart';
import 'package:movie_ticket_booking/domain/entities/seat.dart';
import 'package:movie_ticket_booking/domain/entities/showtime.dart';
import 'package:movie_ticket_booking/domain/entities/movie.dart';

class BookingDraft {
  final Movie? movie;
  final Cinema? cinema;
  final Showtime? showtime;
  final List<Seat> seats;
  final String? paymentMethod;
  final String? date;
  final String? auditorium;
  final int? totalPrice;

  BookingDraft({
    this.movie,
    this.cinema,
    this.showtime,
    this.seats = const [],
    this.paymentMethod,
    this.date,
    this.auditorium,
    this.totalPrice,
  });

  BookingDraft copyWith({
    Movie? movie,
    Cinema? cinema,
    Showtime? showtime,
    List<Seat>? seats,
    String? paymentMethod,
    String? date,
    String? auditorium,
    int? totalPrice,
  }) {
    return BookingDraft(
      movie: movie ?? this.movie,
      cinema: cinema ?? this.cinema,
      showtime: showtime ?? this.showtime,
      seats: seats ?? this.seats,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      date: date ?? this.date,
      auditorium: auditorium ?? this.auditorium,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}