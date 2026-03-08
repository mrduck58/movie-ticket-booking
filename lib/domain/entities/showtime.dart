class Showtime {
  final String id;
  final String cinemaId;
  final String format; 
  final String auditorium;
  final double price;
  final List<String> times; 

  const Showtime({
    required this.id,
    required this.cinemaId,
    required this.format,
    required this.auditorium,
    required this.price,
    required this.times,
  });
}