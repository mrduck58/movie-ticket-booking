import '../../domain/entities/cinema.dart';
import '../../domain/entities/movie.dart';

class SearchState {

  final List<Cinema> cinemas;
  final List<Movie> movies;

  const SearchState({
    required this.cinemas,
    required this.movies,
  });

  const SearchState.empty()
      : cinemas = const [],
        movies = const [];
}