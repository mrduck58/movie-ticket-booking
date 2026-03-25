import '../entities/cinema.dart';
import '../entities/movie.dart';

class SearchResultEntity {
  final List<Cinema> cinemas;
  final List<Movie> movies;

  const SearchResultEntity({
    required this.cinemas,
    required this.movies,
  });
}

abstract class SearchRepository {
  Future<SearchResultEntity> search(String keyword);
}