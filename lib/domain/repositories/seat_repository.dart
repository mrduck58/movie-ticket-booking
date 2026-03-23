import 'package:movie_ticket_booking/features/seat_selection/data/models/seat_map_model.dart';

abstract class SeatRepository {
  Future<SeatMapModel> getSeats(String showtimeId);
}