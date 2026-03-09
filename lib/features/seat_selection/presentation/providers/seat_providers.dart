import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../domain/entities/seat.dart';
import '../../../../domain/repositories/seat_repository.dart';

import '../../data/datasources/seat_mock_datasource.dart';
import '../../data/repositories/seat_repository_impl.dart';

final seatDatasourceProvider =
    Provider<SeatMockDatasource>((ref) {
  return SeatMockDatasourceImpl();
});

final seatRepositoryProvider =
    Provider<SeatRepository>((ref) {

  final ds = ref.watch(seatDatasourceProvider);

  return SeatRepositoryImpl(ds);
});

final seatsProvider =
    FutureProvider<List<Seat>>((ref) {

  final repo = ref.watch(seatRepositoryProvider);

  return repo.getSeats();
});

final selectedSeatsProvider =
    StateNotifierProvider<SeatSelectionNotifier, List<Seat>>(
  (ref) => SeatSelectionNotifier(),
);

class SeatSelectionNotifier extends StateNotifier<List<Seat>> {
  SeatSelectionNotifier() : super([]);

  void toggleSeat(Seat seat) {
    if (state.any((s) => s.id == seat.id)) {
      state = state.where((s) => s.id != seat.id).toList();
    } else {
      state = [...state, seat];
    }
  }

  void clear() {
    state = [];
  }
}