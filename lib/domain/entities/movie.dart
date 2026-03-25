import 'package:movie_ticket_booking/domain/entities/cast.dart';
import 'package:movie_ticket_booking/domain/entities/genre.dart';

class Movie {
  final String id;
  final String title;
  final String posterUrl;
  final String director;
  final double rating;
  final int durationMin;
  final List<Genre> genres;
  final DateTime releaseDate;
  final String trailer;
  final List<Cast> cast;
  final String status;
  final String synopsis;
  Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.director,
    required this.rating,
    required this.durationMin,
    required this.genres,
    required this.releaseDate,
    required this.trailer,
    required this.cast,
    required this.status,
    required this.synopsis
  });
}
