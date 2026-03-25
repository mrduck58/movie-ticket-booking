import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class MovieApiDatasource implements MovieDatasource {

  final String baseUrl = "https://localhost:7132/api/movies";

  @override
  Future<List<MovieModel>> getMovies() async {
    final response = await http.get(Uri.parse(baseUrl));

    print(response.body);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => MovieModel.fromJson(e)).toList();
    } else {
      throw Exception("Error: ${response.body}");
    }
  }

  @override
  Future<MovieModel> getMovieById(String id) async {
    final response = await http.get(
      Uri.parse("$baseUrl/$id"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return MovieModel.fromJson(data);
    } else {
      throw Exception("Error: ${response.body}");
    }
  }
}

abstract class MovieDatasource {
  Future<List<MovieModel>> getMovies();
  Future<MovieModel> getMovieById(String id);
}