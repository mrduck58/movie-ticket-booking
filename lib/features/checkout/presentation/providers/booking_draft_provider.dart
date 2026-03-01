import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class BookingDraft {
  final String? movieId;
  final String? showtimesId;
  final List<String> selectedSeatIds;

  const BookingDraft({
    this.movieId,
    this.showtimesId,
    this.selectedSeatIds = const [],
  });

  BookingDraft copyWith({
    String? movieId,
    String? showtimesId,
    List<String>? selectedSeatIds,
  }) {
    return BookingDraft(
      movieId: movieId ?? this.movieId,
      showtimesId: showtimesId ?? this.showtimesId,
      selectedSeatIds: selectedSeatIds ?? this.selectedSeatIds,
    );
  }
}

class BookingDraftNotifier extends StateNotifier<BookingDraft> {
  BookingDraftNotifier() : super(const BookingDraft());

  void setMovie(String movieId) {
    state = state.copyWith(movieId: movieId);
  }

  void setShowtime(String showtimesId) {
    state = state.copyWith(showtimesId: showtimesId, selectedSeatIds: []);
  }

  void toggleSeat(String seatId) {
    final seats = [...state.selectedSeatIds];
    if (seats.contains(seatId)) {
      seats.remove(seatId);
    } else {
      seats.add(seatId);
    }
    state = state.copyWith(selectedSeatIds: seats);
  }

  void clear() {
    state = const BookingDraft();
  }
}

final bookingDraftProvider = StateNotifierProvider<BookingDraftNotifier, BookingDraft>(
  (ref) => BookingDraftNotifier());