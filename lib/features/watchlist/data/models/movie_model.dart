import '../../../../domain/entities/movie.dart';
import '../../../../domain/entities/cast.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.id,
    required super.title,
    required super.posterUrl,
    required super.durationMin,
    required super.rating,
    required super.genres,
    required super.releaseDate,
    required super.trailer,
    required super.cast,
    required super.director,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['movieId'] ?? "",
      title: json['title'] ?? "",

      durationMin: json['duration'] ?? 0,

      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,

      posterUrl: json['posterUrl'] ?? "https://via.placeholder.com/300x400",

      releaseDate: json['releaseDate'] != null
          ? DateTime.parse(json['releaseDate'])
          : DateTime.now(),

      trailer: json['trailerUrl'] ?? "",

      genres: [], // backend chưa có

      cast: [], // backend chưa có
      director: json['director'] ?? "",
    );
  }
}
