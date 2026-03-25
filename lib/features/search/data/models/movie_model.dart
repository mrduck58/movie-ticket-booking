import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.id,
    required super.title,
    required super.titleVn,
    required super.posterUrl,
    required super.rating,
    required super.duration,
    required super.status,
    required super.director,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: (json['movieId'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      titleVn: (json['titleVn'] ?? '').toString(),
      posterUrl: (json['posterUrl'] ?? '').toString(),
      rating: _parseDouble(json['rating']),
      duration: _parseInt(json['duration']),
      status: (json['status'] ?? '').toString(),
      director: (json['director'] ?? '').toString(),
    );
  }

  static double _parseDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  static int _parseInt(dynamic value) {
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}