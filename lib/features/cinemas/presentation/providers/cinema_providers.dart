import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:movie_ticket_booking/domain/entities/movie.dart';
import 'package:movie_ticket_booking/features/cinemas/data/datasources/cinema_api_datasource.dart';

import '../../../../domain/entities/cinema.dart';
import '../../../../domain/repositories/cinema_repository.dart';
//import '../../data/datasources/cinema_mock_datasource.dart';
import '../../data/repositories/cinema_repository_impl.dart';

final dioProvider = Provider((ref) {
  return Dio(BaseOptions(
    baseUrl: 'https://localhost:7132/api',
  ));
});

final cinemaRemoteDataSourceProvider = Provider<CinemaDatasource>((ref) {
  final dio = ref.watch(dioProvider);
  return CinemaApiDataSource(dio);
});

final cinemaRepositoryProvider = Provider<CinemaRepository>((ref) {
  final remote = ref.watch(cinemaRemoteDataSourceProvider);
  return CinemaRepositoryImpl(remote);
});

final cinemasByMovieProvider = FutureProvider.family<List<Cinema>, String>((ref, movieId) async {
  return ref.read(cinemaRepositoryProvider).getCinemasByMovie(movieId);
});

final cinemaProvider = FutureProvider.family<Cinema, String>((ref, cinemaId) {
  return ref.read(cinemaRepositoryProvider).getCinemaById(cinemaId);
});

class FavoriteCinemasNotifier extends StateNotifier<Set<String>> {
  FavoriteCinemasNotifier() : super(<String>{});
  bool _initialized = false;

  void initFrom(List<Cinema> cinemas) {
    if (_initialized) return;
    _initialized = true;
    state = cinemas.where((c) => c.isFavorite).map((c) => c.id).toSet();
  }

  void toggle(String id) {
    final next = {...state};
    if (next.contains(id)) {
      next.remove(id);
    } else {
      next.add(id);
    }
    state = next;
  }
}

final favoriteCinemasProvider =
    StateNotifierProvider<FavoriteCinemasNotifier, Set<String>>((ref) {
  return FavoriteCinemasNotifier();
});
final allCinemasProvider = FutureProvider<List<Cinema>>((ref) async {
  return ref.read(cinemaRepositoryProvider).getCinemas();
});
// Provider lấy danh sách phim theo CinemaId
final moviesByCinemaProvider = FutureProvider.family<List<Movie>, String>((ref, cinemaId) async {
  return ref.read(cinemaRepositoryProvider).getMoviesByCinema(cinemaId);
});