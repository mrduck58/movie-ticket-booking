import '../entities/seat.dart';

abstract class SeatRepository {
  Future<List<Seat>> getSeats();
}