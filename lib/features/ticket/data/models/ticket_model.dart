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
    required super.director,
    required super.ageRating,
    required super.genres,
    required super.qrData,
    super.remind,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      title: json['title'],
      poster: json['poster'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      cinema: json['cinema'],
      room: json['room'],
      seats: List<String>.from(json['seats']),
      duration: json['duration'],
      director: json['director'],
      ageRating: json['ageRating'],
      genres: List<String>.from(json['genres']),
      qrData: json['qrData'],
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
      "director": director,
      "ageRating": ageRating,
      "genres": genres,
      "qrData": qrData,
      "remind": remind,
    };
  }
}