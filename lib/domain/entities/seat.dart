class Seat {
  final String seatId;
  final String seatName;
  final String status;
  final String? showtimeTicketTypeId;

  const Seat({
    required this.seatId,
    required this.seatName,
    required this.status,
    this.showtimeTicketTypeId,
  });

  String get row => seatName.substring(0, 1);

  int get number => int.parse(seatName.substring(1));

  bool get isBooked => status == "BOOKED";

  bool get isLocked => status == "LOCKED";

  bool get isAvailable => status == "AVAILABLE";
}