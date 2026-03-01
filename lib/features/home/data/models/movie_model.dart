class MovieModel {
  final String id;
  final String title;
  final String posterUrl;
  final double rating;
  final int durationMin;
  final List<String> genres;
  final DateTime releaseDate;

  const MovieModel({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.rating,
    required this.durationMin,
    required this.genres,
    required this.releaseDate,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] as String,
      title: json['title'] as String,
      posterUrl: json['posterUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      durationMin: (json['durationMin'] as num).toInt(),
      genres: (json['genres'] as List).map((e) => e.toString()).toList(),
      releaseDate: DateTime.parse(json['releaseDate'] as String),
    );
  }
}