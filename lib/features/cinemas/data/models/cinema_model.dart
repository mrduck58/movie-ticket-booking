import '../../../../domain/entities/cinema.dart';

class CinemaModel extends Cinema {
  const CinemaModel({
    required super.id,
    required super.name,
    required super.location,
    required super.isFavorite,
    required super.rating,
    required super.hotline,
    required super.imageUrl,
  });

  factory CinemaModel.fromJson(Map<String, dynamic> json) {
    return CinemaModel(
      id: json['cinemaId'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      isFavorite: (json['is_favorite'] as bool?) ?? false,
      rating: (json['rating'] as String?) ?? "",
      hotline: (json['hotline'] as String?) ?? "",
      imageUrl:
          (json['imageUrl'] as String?) ?? "https://via.placeholder.com/150",
    );
  }

  Cinema toEntity() => Cinema(
    id: id,
    name: name,
    location: location,
    isFavorite: isFavorite,
    rating: rating,
    hotline: hotline,
    imageUrl: imageUrl,
  );
}
