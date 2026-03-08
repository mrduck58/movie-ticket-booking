import '../datasources/movie_mock_datasource.dart';
import '../models/movie_model.dart';

class MovieRepository {

  final MovieMockDatasource datasource;

  MovieRepository(this.datasource);

  Future<List<MovieModel>> getMovies() {
    return datasource.getMovies();
  }

}