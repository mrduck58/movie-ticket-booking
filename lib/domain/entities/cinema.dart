class Cinema {
  final String id;
  final String name;
  final String location;
  final String rating;
  final String hotline;
  final String imageUrl;
  final bool isFavorite;

  const Cinema({
    required this.id,
    required this.name,
    required this.location,
    required this.isFavorite,
    required this.rating,
    required this.hotline,
    required this.imageUrl,
  });

  Cinema copyWith({bool? isFavorite}) {
    return Cinema(
      id: id,
      name: name,
      location: location,
      isFavorite: isFavorite ?? this.isFavorite,
      rating: rating,
      hotline: hotline,
      imageUrl: imageUrl ?? "https://via.placeholder.com/150",
    );
  }
}