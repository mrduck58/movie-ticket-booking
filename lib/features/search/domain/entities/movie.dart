class Movie {
  final String id;
  final String title;
  final String titleVn;
  final String posterUrl;
  final double rating;
  final int duration;
  final String status;
  final String director;

  const Movie({
    required this.id,
    required this.title,
    required this.titleVn,
    required this.posterUrl,
    required this.rating,
    required this.duration,
    required this.status,
    required this.director,
  });
}