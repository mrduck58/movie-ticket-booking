import '../../domain/entities/cinema.dart';

class CinemaModel extends Cinema {
  const CinemaModel({
    required super.id,
    required super.name,
    required super.location,
    required super.rating,
    required super.hotline,
  });

  factory CinemaModel.fromJson(Map<String, dynamic> json) {
    return CinemaModel(
      id: (json['cinemaId'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      location: (json['location'] ?? '').toString(),
      rating: _parseDouble(json['rating']),
      hotline: (json['hotline'] ?? '').toString(),
    );
  }

  static double _parseDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }
}