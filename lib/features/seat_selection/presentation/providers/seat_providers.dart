import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/seat_mock_datasource.dart';
import '../../data/models/seat_map_model.dart';

final seatDataSourceProvider = Provider((ref) => SeatMockDataSource());

final seatMapProvider = FutureProvider.family<SeatMapModel, String>((ref, showtimeId) async {
  return ref.watch(seatDataSourceProvider).fetchSeatMap(showtimeId);
});