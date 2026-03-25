class Genre {
  final String genreId;
  final String name;

  Genre({
    required this.genreId,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      genreId: json['genreId'],
      name: json['name'],
    );
  }
}