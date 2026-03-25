import 'package:dio/dio.dart';
import '../models/cinema_model.dart';

class CinemaApiDataSource implements CinemaDatasource {
  final Dio dio;

  CinemaApiDataSource(this.dio);

  @override
  Future<List<CinemaModel>> getCinemasByMovie(String movieId) async {
    final response = await dio.get('/movies/$movieId/cinemas');

    final data = response.data;

    if (data is! List) {
      throw Exception('Invalid response format');
    }

    return data
        .map((e) => CinemaModel.fromJson(e))
        .toList();
  }
  
  @override
  Future<CinemaModel> getCinemaById(String cinemaId) async {
    final response = await dio.get('/cinemas/$cinemaId');

    final data = response.data;

    if (data is! Map<String, dynamic>) {
      throw Exception('Invalid response format');
    }

    return CinemaModel.fromJson(data);
  }
}

abstract class CinemaDatasource {
  Future<List<CinemaModel>> getCinemasByMovie(String movieId);
  Future<CinemaModel> getCinemaById(String cinemaId);
}