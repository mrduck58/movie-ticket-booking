import 'package:dio/dio.dart';
import 'package:movie_ticket_booking/features/home/data/models/movie_model.dart';
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
  @override
  Future<List<CinemaModel>> getCinemas() async {
    final response = await dio.get('/cinemas'); // Gọi tới api/cinemas

    final data = response.data;
    if (data is! List) throw Exception('Invalid response format');

    return data.map((e) => CinemaModel.fromJson(e)).toList();
  }
  @override
Future<List<MovieModel>> getMoviesByCinema(String cinemaId) async {
  // Đường dẫn khớp với [HttpGet("{cinemaId}/movies")] của C#
  final response = await dio.get('/cinemas/$cinemaId/movies');

  final data = response.data;
  if (data is! List) throw Exception('Invalid response format');

  // Giả sử bạn đã có MovieModel.fromJson
  return data.map((e) => MovieModel.fromJson(e)).toList();
}
}

abstract class CinemaDatasource {
  Future<List<CinemaModel>> getCinemasByMovie(String movieId);
  Future<CinemaModel> getCinemaById(String cinemaId);
  Future<List<CinemaModel>> getCinemas();
  Future<List<MovieModel>> getMoviesByCinema(String cinemaId);
}