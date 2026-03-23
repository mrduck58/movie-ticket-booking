import 'package:dio/dio.dart';
import '../models/seat_map_model.dart';

class SeatApiDatasource implements SeatDatasource {
  final Dio dio;

  SeatApiDatasource(this.dio);

  Future<SeatMapModel> getSeats(String showtimeId) async {
    final response = await dio.get('/showtimes/$showtimeId/seats');

    if (response.statusCode == 200) {
      return SeatMapModel.fromJson(response.data);
    } else {
      throw Exception("Failed to load seats");
    }
  }
}

abstract class SeatDatasource {
  Future<SeatMapModel> getSeats(String showtimeId);
}