class ShowtimeModel {
  final String id;
  final String movieId;
  final String cinemaId;
  final DateTime date;
  final String format;      
  final String auditorium;  
  final double price;       
  final List<String> times;

  const ShowtimeModel({
    required this.id,
    required this.movieId,
    required this.cinemaId,
    required this.date,
    required this.format,
    required this.auditorium,
    required this.price,
    required this.times,
  });

  factory ShowtimeModel.fromJson(Map<String, dynamic> json) {
    return ShowtimeModel(
      id: json['id'] as String,
      movieId: json['movieId'] as String,
      cinemaId: json['cinemaId'] as String,
      date: DateTime.parse(json['date'] as String),
      format: json['format'] as String,
      auditorium: (json['auditorium'] as String?) ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      times: (json['times'] as List).map((e) => e.toString()).toList(),
    );
  }
}