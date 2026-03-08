class BookingDraft {
  final String movieTitle;
  final String cinema;
  final String auditorium;
  final List<String> seats;
  final String date;
  final String hours;

  const BookingDraft({
    required this.movieTitle,
    required this.cinema,
    required this.auditorium,
    required this.seats,
    required this.date,
    required this.hours,
  });
}