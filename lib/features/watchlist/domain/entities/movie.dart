import '../../../../domain/entities/cast.dart';
enum MovieListType {
  favorite,
  watched;

  String get apiValue {
    switch (this) {
      case MovieListType.favorite:
        return 'FAVORITE';
      case MovieListType.watched:
        return 'WATCHED';
    }
  }

  static MovieListType fromString(String? value) {
    switch ((value ?? '').toUpperCase()) {
      case 'WATCHED':
        return MovieListType.watched;
      case 'FAVORITE':
      default:
        return MovieListType.favorite;
    }
  }
}

class Movie {
  final String watchListId;
  final String id;
  final String title;
  final String posterUrl;
  final MovieListType type;
  final DateTime? createdAt;
  final int? durationMin;
  final String? director;
  final double? rating;
  final List<String> genres;

  final DateTime releaseDate;
  final String trailer;
  final List<Cast> cast;
  final String status;
  final String synopsis;

  const Movie({
    required this.watchListId,
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.type,
    required this.createdAt,
    required this.durationMin,
    required this.director,
    required this.rating,
    required this.genres,
    required this.releaseDate,
    required this.trailer,
    required this.cast,
    required this.status,
    required this.synopsis,
  });

  bool get isWatched => type == MovieListType.watched;

  bool get isInWatchlist => type == MovieListType.favorite;

  Movie copyWith({
    String? watchListId,
    String? id,
    String? title,
    String? posterUrl,
    MovieListType? type,
    DateTime? createdAt,
    int? durationMin,
    String? director,
    double? rating,
    List<String>? genres,
    DateTime? releaseDate,
    String? trailer,
    List<Cast>? cast,
    String? status,
    String? synopsis,
  }) {
    return Movie(
      watchListId: watchListId ?? this.watchListId,
      id: id ?? this.id,
      title: title ?? this.title,
      posterUrl: posterUrl ?? this.posterUrl,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      durationMin: durationMin ?? this.durationMin,
      director: director ?? this.director,
      rating: rating ?? this.rating,
      genres: genres ?? this.genres,
      releaseDate: releaseDate ?? this.releaseDate,
      trailer: trailer ?? this.trailer,
      cast: cast ?? this.cast,
      status: status ?? this.status,
      synopsis: synopsis ?? this.synopsis,
    );
  }
}