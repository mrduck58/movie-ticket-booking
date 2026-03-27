import '../../domain/entities/ticket.dart';

class TicketModel extends Ticket {
  TicketModel({
    required super.title,
    required super.poster,
    required super.startTime,
    required super.endTime,
    required super.cinema,
    required super.room,
    required super.seats,
    required super.duration,
    required super.rating,
    required super.genres,
    required super.qrDatas,
    super.remind,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      title: json['title'] ?? '',
      poster: json['poster'] ?? '',
      startTime: json['startTime'] != null ? DateTime.parse(json['startTime']) : DateTime.now(),
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : DateTime.now(),
      cinema: json['cinema'] ?? '',
      room: json['room'] ?? '',
      seats: List<String>.from(json['seats'] ?? []),
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      genres: List<String>.from(json['genres'] ?? []),
      qrDatas: List<String>.from(json['qrDatas'] ?? []),
      remind: json['remind'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "poster": poster,
      "startTime": startTime.toIso8601String(),
      "endTime": endTime.toIso8601String(),
      "cinema": cinema,
      "room": room,
      "seats": seats,
      "duration": duration,
      "rating": rating,
      "genres": genres,
      "qrDatas": qrDatas,
      "remind": remind,
    };
  }
}