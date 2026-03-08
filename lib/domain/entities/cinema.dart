class Cinema {
  final String id;
  final String name;
  final bool isFavorite;

  const Cinema({
    required this.id,
    required this.name,
    required this.isFavorite,
  });

  Cinema copyWith({bool? isFavorite}) {
    return Cinema(
      id: id,
      name: name,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}