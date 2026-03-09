import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/cinema.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/search_repository.dart';

import 'search_provider.dart';
import 'search_state.dart';

class SearchController extends AsyncNotifier<SearchState> {

  late final SearchRepository _repo;

  List<Cinema> _allCinemas = [];
  List<Movie> _allMovies = [];

  @override
  Future<SearchState> build() async {

    _repo = ref.read(searchRepositoryProvider);

    final cinemas = await _repo.getCinemas();
    final movies = await _repo.getMovies();

    _allCinemas = cinemas;
    _allMovies = movies;

    return SearchState(
      cinemas: cinemas,
      movies: movies,
    );
  }

  void searchCinema(String keyword) {

    final filtered = _allCinemas
        .where((c) =>
            c.name.toLowerCase().contains(keyword.toLowerCase()))
        .toList();

    state = AsyncData(
      SearchState(
        cinemas: filtered,
        movies: _allMovies,
      ),
    );
  }

  void searchMovie(String keyword) {

    final filtered = _allMovies
        .where((m) =>
            m.title.toLowerCase().contains(keyword.toLowerCase()))
        .toList();

    state = AsyncData(
      SearchState(
        cinemas: _allCinemas,
        movies: filtered,
      ),
    );
  }
}