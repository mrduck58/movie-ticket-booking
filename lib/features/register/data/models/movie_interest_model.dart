class MovieInterestModel {
  final String id;   // 👈 thêm cái này
  final String name;
  final bool isSelected;

  const MovieInterestModel({
    required this.id,
    required this.name,
    this.isSelected = false,
  });

  MovieInterestModel copyWith({
    String? id,
    String? name,
    bool? isSelected,
  }) {
    return MovieInterestModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}