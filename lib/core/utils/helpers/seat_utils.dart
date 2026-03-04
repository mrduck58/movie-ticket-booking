class SeatUtils {
  static int calculateTotal({
    required int seatCount,
    required int pricePerSeat,
  }) {
    return seatCount * pricePerSeat;
  }
}