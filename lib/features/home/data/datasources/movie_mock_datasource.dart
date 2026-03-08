import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/movie_model.dart';

class MovieMockDatasource {

  Future<List<MovieModel>> getMovies() async {

    final jsonString = await rootBundle.loadString("assets/mock/movies.json");

    final List data = json.decode(jsonString);

    return data.map((e) => MovieModel.fromJson(e)).toList();
  }

}