import '../../domain/entities/cinema.dart';
import '../../domain/entities/movie.dart';

class SearchState {
  final String keyword;
  final List<Cinema> cinemas;
  final List<Movie> movies;

  const SearchState({
    required this.keyword,
    required this.cinemas,
    required this.movies,
  });

  const SearchState.empty()
      : keyword = '',
        cinemas = const [],
        movies = const [];

  bool get hasKeyword => keyword.trim().isNotEmpty;
  bool get isEmptyResult => cinemas.isEmpty && movies.isEmpty;
}