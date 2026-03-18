import 'package:movie_ticket_booking/domain/entities/movie.dart';
import 'package:movie_ticket_booking/domain/entities/cast.dart';

class MovieModel {
  final String movieId;
  final String title;
  final String? titleVn;
  final int duration;
  final double? rating;

  final String? posterUrl;
  final DateTime? releaseDate;

  final String? trailer;
  final List<Cast>? cast;

  MovieModel({
    required this.movieId,
    required this.title,
    this.titleVn,
    required this.duration,
    this.rating,
    this.posterUrl,
    this.releaseDate,
    this.trailer,
    this.cast,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      movieId: json['movieId'],
      title: json['title'],
      titleVn: json['titleVn'],
      duration: json['duration'],
      rating: (json['rating'] as num?)?.toDouble(),
      posterUrl: json['posterUrl'],
      releaseDate: json['releaseDate'] != null
          ? DateTime.parse(json['releaseDate'])
          : null,
      trailer: json['trailerUrl'],
      cast: [],
    );
  }

  Movie toEntity() {
    return Movie(
      id: movieId,
      title: title,
      posterUrl: posterUrl ?? "https://via.placeholder.com/300",
      rating: rating ?? 0.0,
      durationMin: duration,
      genres: [],
      releaseDate: releaseDate ?? DateTime.now(),
      trailer: trailer ?? "",
      cast: cast ?? [],
      director: '',
    );
  }
}
