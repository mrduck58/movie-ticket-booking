import '../../../../domain/entities/cinema.dart';
import '../../../../domain/repositories/cinema_repository.dart';
import '../datasources/cinema_mock_datasource.dart';

class CinemaRepositoryImpl implements CinemaRepository {
  CinemaRepositoryImpl(this.local);
  final CinemaMockDataSource local;

  @override
  Future<List<Cinema>> getCinemas() async {
    final models = await local.loadCinemas();
    return models.map((m) => m.toEntity()).toList();
  }
}