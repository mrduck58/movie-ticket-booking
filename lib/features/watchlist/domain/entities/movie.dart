class Movie {
  final String id;
  final String title;
  final String imageUrl;
  final String? duration;
  final String? director;
  final String? ageRating;
  final List<String>? genres;

  const Movie({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.duration,
    this.director,
    this.ageRating,
    this.genres,
  });
}