import 'package:movie_ticket_booking/features/watchlist/domain/entities/movie.dart';

class MovieModel {
  final String id;
  final String title;
  final String posterUrl;
  final double rating;
  final int durationMin;
  final List<String> genres;
  final DateTime releaseDate;
  final String trailer;
  final List<CastModel> cast;

  MovieModel({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.rating,
    required this.durationMin,
    required this.genres,
    required this.releaseDate,
    required this.trailer,
    required this.cast,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json["id"],
      title: json["title"],
      posterUrl: json["posterUrl"],
      rating: (json["rating"] as num).toDouble(),
      durationMin: json["durationMin"],
      genres: List<String>.from(json["genres"]),
      releaseDate: DateTime.parse(json["releaseDate"]),
      trailer: json["trailer"],
      cast: (json["cast"] as List)
          .map((e) => CastModel.fromJson(e))
          .toList(),
    );
  }

  Movie toEntity() {
    return Movie(
      id: id,
      title: title,
      imageUrl: posterUrl,
      duration: '${durationMin} min',
      genres: genres,
      rating: rating,
      posterUrl: posterUrl,
    );
  }
}

class CastModel {
  final String name;
  final String imageUrl;

  CastModel({
    required this.name,
    required this.imageUrl,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      name: json["name"],
      imageUrl: json["imageUrl"],
    );
  }
}