import 'dart:convert';
import 'package:flutter/services.dart';

import '../models/movie_model.dart';

class WatchlistLocalDataSource {
  Future<Map<String, dynamic>> _loadJson() async {
    final raw = await rootBundle.loadString('assets/mock/watchlist.json');
    return json.decode(raw) as Map<String, dynamic>;
  }

  Future<List<MovieModel>> getWatchlist() async {
    final data = await _loadJson();
    final list = (data['watchlist'] as List? ?? const []);
    return list.map((e) => MovieModel.fromJson(e)).toList();
  }

  Future<List<MovieModel>> getWatched() async {
    final data = await _loadJson();
    final list = (data['watched'] as List? ?? const []);
    return list.map((e) => MovieModel.fromJson(e)).toList();
  }
}