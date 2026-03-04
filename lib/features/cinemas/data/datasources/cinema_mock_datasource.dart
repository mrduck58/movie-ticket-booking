import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/cinema_model.dart';

abstract class CinemaMockDataSource {
  Future<List<CinemaModel>> loadCinemas();
}

class CinemaMockDataSourceImpl implements CinemaMockDataSource {
  CinemaMockDataSourceImpl({this.assetPath = 'assets/mock/cinemas.json'});
  final String assetPath;

  @override
  Future<List<CinemaModel>> loadCinemas() async {
    final raw = await rootBundle.loadString(assetPath);
    final decoded = jsonDecode(raw);

    if (decoded is! List) {
      throw const FormatException('cinemas.json must be a JSON array');
    }

    return decoded.map((e) => CinemaModel.fromJson(Map<String, dynamic>.from(e))).toList();
  }
}