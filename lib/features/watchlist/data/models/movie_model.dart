import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.id,
    required super.title,
    required super.imageUrl,
    super.duration,
    super.director,
    super.ageRating,
    super.genres,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      imageUrl: (json['imageUrl'] ?? '').toString(),
      duration: json['duration']?.toString(),
      director: json['director']?.toString(),
      ageRating: json['ageRating']?.toString(),
      genres: (json['genres'] is List)
          ? List<String>.from(json['genres'])
          : null,
    );
  }
}