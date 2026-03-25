import 'dart:convert';
import 'package:flutter/services.dart';

import '../models/showtime_model.dart';

// abstract class ShowtimeMockDatasource {
//   Future<List<ShowtimeModel>> getShowtimes(String cinemaId);
// }

// class ShowtimeMockDatasourceImpl implements ShowtimeMockDatasource {
//   @override
//   Future<List<ShowtimeModel>> getShowtimes(String cinemaId) async {
//     final raw = await rootBundle.loadString('assets/mock/showtimes.json');
//     final list = jsonDecode(raw) as List;

//     return list
//         .map((e) => ShowtimeModel.fromJson(e))
//         .where((e) => e.cinemaId == cinemaId)
//         .toList();
//   }
// }