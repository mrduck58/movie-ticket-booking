import 'dart:convert';
import 'package:flutter/services.dart';

import '../models/cinema_model.dart';
import '../models/movie_model.dart';

class SearchMockDatasource {

  Future<List<CinemaModel>> getCinemas() async {

    final jsonString =
        await rootBundle.loadString('assets/mock/cinemas.json');

    final List data = json.decode(jsonString);

    return data.map((e) => CinemaModel.fromJson(e)).toList();
  }

  Future<List<MovieModel>> getMovies() async {

    final jsonString =
        await rootBundle.loadString('assets/mock/movies.json');

    final List data = json.decode(jsonString);

    return data.map((e) => MovieModel.fromJson(e)).toList();
  }
}