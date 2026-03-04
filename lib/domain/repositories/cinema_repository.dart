import '../entities/cinema.dart';

abstract class CinemaRepository {
  Future<List<Cinema>> getCinemas();
}