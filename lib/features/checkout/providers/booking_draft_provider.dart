import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class BookingDraft {
  final String movieId;
  final String? cinemaId;
  final String? showtime;
  final List<String> seats;
  final String? paymentMethod;

  const BookingDraft({
    required this.movieId,
    this.cinemaId,
    this.showtime,
    this.seats = const [],
    this.paymentMethod,
  });

  BookingDraft copyWith({
    String? cinemaId,
    String? showtime,
    List<String>? seats,
    String? paymentMethod,
  }) {
    return BookingDraft(
      movieId: movieId,
      cinemaId: cinemaId ?? this.cinemaId,
      showtime: showtime ?? this.showtime,
      seats: seats ?? this.seats,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}

final bookingDraftProvider =
    StateProvider<BookingDraft?>((ref) => null);