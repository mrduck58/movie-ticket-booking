import '../../../../domain/entities/cinema.dart';
import '../../../../domain/repositories/cinema_repository.dart';
import '../datasources/cinema_api_datasource.dart';

class CinemaRepositoryImpl implements CinemaRepository {
  CinemaRepositoryImpl(this.remote);
  final CinemaDatasource remote;

  @override
  Future<List<Cinema>> getCinemasByMovie(String movieId) async {
    final models = await remote.getCinemasByMovie(movieId);
    return models.map((m) => m.toEntity()).toList();
  }
  
  @override
  Future<Cinema> getCinemaById(String cinemaId) async {
    final model = await remote.getCinemaById(cinemaId);
    return model.toEntity();
  }
}