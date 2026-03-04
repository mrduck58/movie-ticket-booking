import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/showtime_model.dart';

class ShowtimeMockDataSource {
  Future<List<ShowtimeModel>> fetchShowtimes() async {
    final raw = await rootBundle.loadString('assets/mock/showtimes.json');
    final decoded = jsonDecode(raw) as List;
    return decoded
        .map((e) => ShowtimeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}