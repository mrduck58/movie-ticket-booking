import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/showtimegroup_model.dart';

abstract class ShowtimeApiDatasource {
  Future<List<ShowtimeGroupModel>> getShowtimes(
    String movieId,
    String cinemaId,
    DateTime date,
  );
}

class ShowtimeApiDatasourceImpl implements ShowtimeApiDatasource {
  final Dio dio;

  ShowtimeApiDatasourceImpl(this.dio);

  @override
  Future<List<ShowtimeGroupModel>> getShowtimes(
    String movieId,
    String cinemaId,
    DateTime date,
  ) async {
    final response = await dio.get(
      "/showtimes",
      queryParameters: {
        "movieId": movieId,
        "cinemaId": cinemaId,
        "date": date.toIso8601String(),
      },
    );

    final data = response.data as List;

    return data.map((e) => ShowtimeGroupModel.fromJson(e)).toList();
  }
}