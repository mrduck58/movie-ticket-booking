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
    StateProvider<List<Seat>>((ref) => []);