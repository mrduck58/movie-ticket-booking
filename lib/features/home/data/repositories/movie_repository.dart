import '../datasources/movie_api_datasource.dart';
import '../models/movie_model.dart';

class MovieRepository {
  final MovieDatasource datasource;

  MovieRepository(this.datasource);

  Future<List<MovieModel>> getMovies() {
    return datasource.getMovies();
  }

  Future<MovieModel> getMovieById(String id) {
    return datasource.getMovieById(id);
  }
}
