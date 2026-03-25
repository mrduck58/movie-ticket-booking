import '../../../../domain/entities/showtime_group.dart';
import '../../../../domain/entities/showtime.dart';
import 'showtime_model.dart';

class ShowtimeGroupModel {
  final String ticketType;
  final double price;
  final List<ShowtimeModel> showtimes;

  ShowtimeGroupModel({
    required this.ticketType,
    required this.price,
    required this.showtimes,
  });

  factory ShowtimeGroupModel.fromJson(Map<String, dynamic> json) {
    return ShowtimeGroupModel(
      ticketType: json['ticketType'],
      price: (json['price'] as num).toDouble(),
      showtimes: (json['showtimes'] as List)
          .map((e) => ShowtimeModel.fromJson(e))
          .toList(),
    );
  }

  ShowtimeGroup toEntity() {
    return ShowtimeGroup(
      ticketType: ticketType,
      price: price,
      showtimes: showtimes.map((e) => e.toEntity(price)).toList(),
    );
  }
}