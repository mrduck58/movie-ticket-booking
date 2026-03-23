import 'seat_model.dart';

class SeatMapModel {
  final String showtimeId;
  final String roomName;
  final List<SeatModel> seats;

  SeatMapModel({
    required this.showtimeId,
    required this.roomName,
    required this.seats,
  });

  factory SeatMapModel.fromJson(Map<String, dynamic> json) {
    return SeatMapModel(
      showtimeId: json['showtimeId'],
      roomName: json['roomName'],
      seats: (json['seats'] as List)
          .map((e) => SeatModel.fromJson(e))
          .toList(),
    );
  }
}