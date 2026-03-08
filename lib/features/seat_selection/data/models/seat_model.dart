import '../../../../domain/entities/seat.dart';

class SeatModel {
  final String id;
  final String row;
  final int number;
  final bool taken;

  SeatModel({
    required this.id,
    required this.row,
    required this.number,
    required this.taken,
  });

  factory SeatModel.fromJson(Map<String, dynamic> json) {
    return SeatModel(
      id: json['id'],
      row: json['row'],
      number: json['number'],
      taken: json['taken'],
    );
  }

  Seat toEntity() {
    return Seat(
      id: id,
      row: row,
      number: number,
      taken: taken,
    );
  }
}