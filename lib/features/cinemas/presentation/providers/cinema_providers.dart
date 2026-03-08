import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../domain/entities/cinema.dart';
import '../../../../domain/repositories/cinema_repository.dart';
import '../../data/datasources/cinema_mock_datasource.dart';
import '../../data/repositories/cinema_repository_impl.dart';

final cinemaLocalDataSourceProvider = Provider<CinemaMockDataSource>((ref) {
  return CinemaMockDataSourceImpl();
});

final cinemaRepositoryProvider = Provider<CinemaRepository>((ref) {
  final local = ref.watch(cinemaLocalDataSourceProvider);
  return CinemaRepositoryImpl(local);
});

final cinemasProvider = FutureProvider<List<Cinema>>((ref) async {
  final repo = ref.watch(cinemaRepositoryProvider);
  return repo.getCinemas();
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