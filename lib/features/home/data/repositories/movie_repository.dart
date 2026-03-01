import '../datasources/movie_mock_datasource.dart';
import '../models/movie_model.dart';

abstract class MovieRepository {
  Future<List<MovieModel>> getMovies();
}

class MovieRepositoryImpl implements MovieRepository {
  final MovieMockDataSource datasource;

  MovieRepositoryImpl(this.datasource);

  @override
  Future<List<MovieModel>> getMovies() => datasource.fetchMovies();
}