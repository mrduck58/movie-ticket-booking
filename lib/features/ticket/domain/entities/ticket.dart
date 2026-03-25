class Ticket {
  final String title;
  final String poster;

  final DateTime startTime;
  final DateTime endTime;

  final String cinema;
  final String room;
  final List<String> seats;

  final int duration;
  // final String director;
  final double rating;
  final List<String> genres;

  final String qrData;

  bool remind;

  Ticket({
    required this.title,
    required this.poster,
    required this.startTime,
    required this.endTime,
    required this.cinema,
    required this.room,
    required this.seats,
    required this.duration,
    // required this.director,
    required this.rating,
    required this.genres,
    required this.qrData,
    this.remind = false,
  });

  bool get isFinished => DateTime.now().isAfter(endTime);

  bool get isShowing =>
      DateTime.now().isAfter(startTime) &&
      DateTime.now().isBefore(endTime);

  bool get isUpcoming => DateTime.now().isBefore(startTime);
}