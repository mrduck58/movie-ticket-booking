import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.watchListId,
    required super.id,
    required super.title,
    required super.posterUrl,
    required super.type,
    required super.createdAt,
    required super.durationMin,
    required super.director,
    required super.rating,
    required super.genres,
    required super.releaseDate,
    required super.trailer,
    required super.cast,
    required super.status,
    required super.synopsis
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      watchListId: (json['watchListId'] ?? '').toString(),
      id: (json['movieId'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      posterUrl: (json['posterUrl'] ?? '').toString(),
      type: MovieListType.fromString(json['type']?.toString()),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      durationMin: json['duration'] is num
          ? (json['duration'] as num).toInt()
          : null,
      director: json['director']?.toString(),
      rating: json['rating'] is num
          ? (json['rating'] as num).toDouble()
          : null,
      genres: json['genres'] is List
          ? (json['genres'] as List).map((e) => e.toString()).toList()
          : const [],
      
      releaseDate: json['releaseDate'] != null
          ? DateTime.parse(json['releaseDate'])
          : DateTime.now(),
      trailer: json['trailerUrl'] ?? "",
      cast: [],
      status: json['status'] ?? "",
      synopsis: json['synopsis'] ?? "",
    );
  }

  Map<String, dynamic> toAddJson({
    required String movieId,
    required MovieListType type,
  }) {
    return {
      'movieId': movieId,
      'type': type.apiValue,
    };
  }
}