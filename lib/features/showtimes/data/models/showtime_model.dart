import '../../../../domain/entities/showtime.dart';

class ShowtimeModel {
  final String showtimeId;
  final DateTime startTime;
  final String roomName;

  ShowtimeModel({
    required this.showtimeId,
    required this.startTime,
    required this.roomName,
  });

  factory ShowtimeModel.fromJson(Map<String, dynamic> json) {
    return ShowtimeModel(
      showtimeId: json['showtimeId'],
      startTime: DateTime.parse(json['startTime']),
      roomName: json['roomName'],
    );
  }

  Showtime toEntity(double price) {
    return Showtime(
      showtimeId: showtimeId,
      startTime: startTime,
      roomName: roomName,
      price: price,
    );
  }
}
