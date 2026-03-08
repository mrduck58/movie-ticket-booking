import '../../../../domain/entities/showtime.dart';

class ShowtimeModel {
  final String id;
  final String cinemaId;
  final String format;
  final String auditorium;
  final double price;
  final List<String> times;

  ShowtimeModel({
    required this.id,
    required this.cinemaId,
    required this.format,
    required this.auditorium,
    required this.price,
    required this.times,
  });

  factory ShowtimeModel.fromJson(Map<String, dynamic> json) {
    return ShowtimeModel(
      id: json['id'],
      cinemaId: json['cinema_id'],
      format: json['format'],
      auditorium: json['auditorium'],
      price: (json['price'] as num).toDouble(),
      times: List<String>.from(json['times']),
    );
  }

  Showtime toEntity() {
    return Showtime(
      id: id,
      cinemaId: cinemaId,
      format: format,
      auditorium: auditorium,
      price: price,
      times: times,
    );
  }
}