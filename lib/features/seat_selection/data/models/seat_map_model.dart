class SeatMapModel {
  final String showtimeId;
  final List<String> rows;
  final int cols;
  final Set<String> taken;

  const SeatMapModel({
    required this.showtimeId,
    required this.rows,
    required this.cols,
    required this.taken,
  });

  factory SeatMapModel.fromJson(Map<String, dynamic> json) {
    return SeatMapModel(
      showtimeId: json['showtimeId'] as String,
      rows: (json['rows'] as List).map((e) => e.toString()).toList(),
      cols: (json['cols'] as num).toInt(),
      taken: ((json['taken'] as List?) ?? const [])
          .map((e) => e.toString())
          .toSet(),
    );
  }
}