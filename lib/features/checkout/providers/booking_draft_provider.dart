
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:movie_ticket_booking/domain/entities/combo.dart';
import 'package:movie_ticket_booking/domain/entities/seat.dart';
import 'package:movie_ticket_booking/features/checkout/providers/booking_draft.dart';
import 'package:movie_ticket_booking/domain/entities/movie.dart';
import 'package:movie_ticket_booking/domain/entities/cinema.dart';
import 'package:movie_ticket_booking/domain/entities/showtime.dart';

final bookingDraftProvider =
    StateNotifierProvider<BookingDraftNotifier, BookingDraft>(
  (ref) => BookingDraftNotifier(),
);

class BookingDraftNotifier extends StateNotifier<BookingDraft> {
  BookingDraftNotifier() : super(BookingDraft());

  void setMovie(Movie movie) {
    state = state.copyWith(movie: movie);
  }

  void setCinema(Cinema cinema) {
    state = state.copyWith(cinema: cinema);
  }

  void setShowtime(Showtime showtime, {String? date, String? auditorium}) {
    state = state.copyWith(showtime: showtime, date: date, auditorium: auditorium);
  }

  void setPackage(String package) {
    state = state.copyWith(package: package);
  }

  void setSeats(List<Seat> seats) {
    state = state.copyWith(seats: seats);
  }

  void setCombos(List<Combo> combos) {
    state = state.copyWith(combos: combos);
  }

  void setPayment(String method) {
    state = state.copyWith(paymentMethod: method);
  }

  void reset() {
    state = BookingDraft();
  }
}