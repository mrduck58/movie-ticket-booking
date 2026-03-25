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
    );
  }
}