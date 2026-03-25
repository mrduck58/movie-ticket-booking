import 'package:movie_ticket_booking/domain/entities/genre.dart';
import 'package:movie_ticket_booking/domain/entities/movie.dart';
import 'package:movie_ticket_booking/domain/entities/cast.dart';

class MovieModel {
  final String movieId;
  final String title;
  final String? titleVn;
  final int duration;
  final String? director;
  final double? rating;

  final String? posterUrl;
  final DateTime? releaseDate;

  final String? trailerUrl;

  final List<Cast>? cast;
  final List<Genre>? genres;
  final String? status;
  final String? synopsis;

  MovieModel({
    required this.movieId,
    required this.title,
    this.titleVn,
    required this.duration,
    this.director,
    this.rating,
    this.posterUrl,
    this.releaseDate,
    this.trailerUrl,
    this.cast,
    this.genres,
    this.status,
    this.synopsis,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      movieId: json['movieId'],
      title: json['title'],
      titleVn: json['titleVn'],
      duration: json['duration'],
      director: json['director'],
      rating: (json['rating'] as num?)?.toDouble(),
      posterUrl: json['posterUrl'],
      releaseDate: json['releaseDate'] != null
          ? DateTime.parse(json['releaseDate'])
          : null,

      trailerUrl: json['trailerUrl'],

      cast: (json['casts'] as List<dynamic>?)
          ?.map((e) => Cast.fromJson(e as Map<String, dynamic>))
          .toList(),
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'],
      synopsis: json['description'],
    );
  }

  Movie toEntity() {
    return Movie(
      id: movieId,
      title: title,
      posterUrl: posterUrl ?? "https://via.placeholder.com/300",
      rating: rating ?? 0.0,
      durationMin: duration,
      director: director ?? "Unknown",
      genres: genres ?? [],
      releaseDate: releaseDate ?? DateTime.now(),
      trailer: trailerUrl ?? "",

      cast: cast ?? [],
      status: status ?? "",
      synopsis: synopsis ?? "",
    );
  }
}
