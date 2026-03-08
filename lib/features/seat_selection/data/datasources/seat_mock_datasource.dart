import 'dart:convert';
import 'package:flutter/services.dart';

import '../models/seat_model.dart';

abstract class SeatMockDatasource {
  Future<List<SeatModel>> getSeats();
}

class SeatMockDatasourceImpl implements SeatMockDatasource {

  @override
  Future<List<SeatModel>> getSeats() async {

    final raw = await rootBundle.loadString(
      'assets/mock/seats.json',
    );

    final list = jsonDecode(raw) as List;

    return list
        .map((e) => SeatModel.fromJson(e))
        .toList();
  }
}