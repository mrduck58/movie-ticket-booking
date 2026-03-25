import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../domain/entities/showtime_group.dart';
import '../../../../domain/repositories/showtime_repository.dart';
import '../../data/datasources/showtime_api_datasource.dart';
import '../../data/repositories/showtime_repository_impl.dart';
import '../../data/models/selected_showtime.dart';

/// ✅ Dio
final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: 'https://localhost:7132/api',
    ),
  );
});

/// ✅ Datasource
final showtimeApiDatasourceProvider =
    Provider<ShowtimeApiDatasource>((ref) {
  final dio = ref.read(dioProvider);
  return ShowtimeApiDatasourceImpl(dio);
});

/// ✅ Repository
final showtimeRepositoryProvider =
    Provider<ShowtimeRepository>((ref) {
  final datasource = ref.read(showtimeApiDatasourceProvider);
  return ShowtimeRepositoryImpl(datasource);
});

/// ✅ API call
final showtimesProvider = FutureProvider.family<
    List<ShowtimeGroup>,
    ({String movieId, String cinemaId, DateTime date})>((ref, params) {
  final repo = ref.read(showtimeRepositoryProvider);

  return repo.getShowtimes(
    params.movieId,
    params.cinemaId,
    params.date,
  );
});

/// ✅ selected showtime
final selectedShowtimeProvider =
    StateProvider<SelectedShowtime?>((ref) => null);

/// ✅ selected date
final selectedDateProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});