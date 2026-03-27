import 'package:dio/dio.dart';
import '../models/seat_map_model.dart';

class SeatApiDatasource implements SeatDatasource {
  final Dio dio;

  SeatApiDatasource(this.dio);

  @override
  Future<SeatMapModel> getSeats(String showtimeId) async {
    final response = await dio.get('/api/showtimes/$showtimeId/seats');

    if (response.statusCode == 200) {
      // ignore: avoid_print
      print('[SeatAPI] Response: ${response.data}');
      return SeatMapModel.fromJson(response.data);
    } else {
      throw Exception("Failed to load seats");
    }
  }

  @override
  Future<void> lockSeats(String showtimeId, List<String> seatIds) async {
    final response = await dio.post(
      '/api/showtimes/$showtimeId/lock-seats',
      data: {'seatIds': seatIds},
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Failed to lock seats");
    }
  }
}

abstract class SeatDatasource {
  Future<SeatMapModel> getSeats(String showtimeId);
  Future<void> lockSeats(String showtimeId, List<String> seatIds);
}