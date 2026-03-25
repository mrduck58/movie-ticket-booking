import 'cinema_model.dart';
import 'movie_model.dart';

class SearchResultModel {
  final List<CinemaModel> cinemas;
  final List<MovieModel> movies;

  const SearchResultModel({
    required this.cinemas,
    required this.movies,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      cinemas: (json['cinemas'] as List? ?? [])
          .map((e) => CinemaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      movies: (json['movies'] as List? ?? [])
          .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}