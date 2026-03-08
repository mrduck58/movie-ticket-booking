import '../../../../domain/entities/cinema.dart';

class CinemaModel {
  final String id;
  final String name;
  final bool isFavorite;

  const CinemaModel({
    required this.id,
    required this.name,
    required this.isFavorite,
  });

  factory CinemaModel.fromJson(Map<String, dynamic> json) {
    return CinemaModel(
      id: json['id'] as String,
      name: json['name'] as String,
      isFavorite: (json['is_favorite'] as bool?) ?? false,
    );
  }

  Cinema toEntity() => Cinema(id: id, name: name, isFavorite: isFavorite);
}