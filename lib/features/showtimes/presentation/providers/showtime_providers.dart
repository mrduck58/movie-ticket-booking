import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../domain/entities/showtime.dart';
import '../../../../domain/repositories/showtime_repository.dart';
import '../../data/datasources/showtime_mock_datasource.dart';
import '../../data/repositories/showtime_repository_impl.dart';

final showtimeDatasourceProvider = Provider<ShowtimeMockDatasource>((ref) {
  return ShowtimeMockDatasourceImpl();
});

final showtimeRepositoryProvider = Provider<ShowtimeRepository>((ref) {
  final ds = ref.watch(showtimeDatasourceProvider);
  return ShowtimeRepositoryImpl(ds);
});

final showtimesProvider = FutureProvider.family<List<Showtime>, String>((
  ref,
  cinemaId,
) {
  final repo = ref.watch(showtimeRepositoryProvider);
  return repo.getShowtimes(cinemaId);
});

final selectedShowtimeProvider = StateProvider<String?>((ref) => null);

final selectedDateProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});
