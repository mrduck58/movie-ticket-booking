class Cast {
  final String name;
  final String imageUrl;

  Cast({
    required this.name,
    required this.imageUrl,
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
}