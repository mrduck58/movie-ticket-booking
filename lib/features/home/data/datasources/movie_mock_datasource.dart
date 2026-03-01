import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import '../models/movie_model.dart';

class MovieMockDataSource {
  Future<List<MovieModel>> fetchMovies() async {
    final raw = await rootBundle.loadString('assets/mock/movies.json');
    final decoded = jsonDecode(raw) as List;
    return decoded
    .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
    .toList();
  }
}