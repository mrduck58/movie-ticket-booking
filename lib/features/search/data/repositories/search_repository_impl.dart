import '../../domain/entities/cinema.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_mock_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {

  final SearchMockDatasource datasource;

  SearchRepositoryImpl(this.datasource);

  @override
  Future<List<Cinema>> getCinemas() {
    return datasource.getCinemas();
  }

  @override
  Future<List<Movie>> getMovies() {
    return datasource.getMovies();
  }
}