class Showtime {
  final String showtimeId;
  final String roomName;
  final DateTime startTime;
  final double price;

  Showtime({
    required this.showtimeId,
    required this.roomName,
    required this.startTime,
    required this.price,
  });

  Showtime copyWith({
    double? price,
  }) {
    return Showtime(
      showtimeId: showtimeId,
      roomName: roomName,
      startTime: startTime,
      price: price ?? this.price,
    );
  }
}