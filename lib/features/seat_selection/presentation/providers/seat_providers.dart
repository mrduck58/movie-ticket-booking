import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'package:movie_ticket_booking/core/network/dio_client.dart';
import 'package:movie_ticket_booking/features/seat_selection/data/datasources/seat_api_datasource.dart';
import 'package:movie_ticket_booking/features/seat_selection/data/models/seat_map_model.dart';

import 'package:movie_ticket_booking/core/network/interceptors/auth_interceptor.dart';
import 'package:movie_ticket_booking/features/login/presentation/provider/login_provider.dart';

import '../../../../domain/entities/seat.dart';
import '../../../../domain/repositories/seat_repository.dart';

import '../../data/repositories/seat_repository_impl.dart';

final dioProvider = Provider((ref) {
  return DioClient(
    baseUrl: 'https://localhost:7132',
    interceptors: [
      AuthInterceptor(getToken: () async => ref.read(loginProvider).token),
    ],
  ).dio;
});

final seatDatasourceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return SeatApiDatasource(dio);
});

final seatRepositoryProvider = Provider<SeatRepository>((ref) {
  return SeatRepositoryImpl(ref.read(seatDatasourceProvider));
});

final seatMapProvider = FutureProvider.family<SeatMapModel, String>((
  ref,
  showtimeId,
) {
  return ref.read(seatRepositoryProvider).getSeats(showtimeId);
});

final selectedSeatsProvider =
    StateNotifierProvider<SeatSelectionNotifier, List<Seat>>(
      (ref) => SeatSelectionNotifier(),
    );

class SeatSelectionNotifier extends StateNotifier<List<Seat>> {
  SeatSelectionNotifier() : super([]);

  void toggleSeat(Seat seat) {
    if (state.any((s) => s.seatId == seat.seatId)) {
      state = state.where((s) => s.seatId != seat.seatId).toList();
    } else {
      state = [...state, seat];
    }
  }

  void clear() {
    state = [];
  }
}
