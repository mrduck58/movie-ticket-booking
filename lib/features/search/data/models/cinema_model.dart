import '../../domain/entities/cinema.dart';

class CinemaModel extends Cinema {
  CinemaModel({
    required super.id,
    required super.name,
    required super.isFavorite,
  });

  factory CinemaModel.fromJson(Map<String, dynamic> json) {
    return CinemaModel(
      id: json['id'],
      name: json['name'],
      isFavorite: json['is_favorite'],
    );
  }
}