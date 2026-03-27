import '../../../../domain/entities/seat.dart';

class SeatModel extends Seat {
  const SeatModel({
    required super.seatId,
    required super.seatName,
    required super.status,
    super.showtimeTicketTypeId,
  });

  factory SeatModel.fromJson(Map<String, dynamic> json) {
    return SeatModel(
      seatId: json['seatId'],
      seatName: json['seatName'],
      status: json['status'],
      // Backend trả về field này để dùng khi checkout
      showtimeTicketTypeId: json['showtimeTicketTypeId'],
    );
  }

  Seat toEntity() {
    return Seat(
      seatId: seatId,
      seatName: seatName,
      status: status,
      showtimeTicketTypeId: showtimeTicketTypeId,
    );
  }
}