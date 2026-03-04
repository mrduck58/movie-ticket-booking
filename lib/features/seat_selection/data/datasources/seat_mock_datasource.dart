import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/seat_map_model.dart';

class SeatMockDataSource {
  Future<SeatMapModel> fetchSeatMap(String showtimeId) async {
    final raw = await rootBundle.loadString('assets/mock/seats.json');
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return SeatMapModel.fromJson(decoded);
  }
}