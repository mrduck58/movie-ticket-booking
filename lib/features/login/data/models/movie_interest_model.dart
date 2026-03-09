
class MovieInterestModel {
  final String name;
  final bool isSelected;

  const MovieInterestModel({
    required this.name,
    this.isSelected = false,
  });

  MovieInterestModel copyWith({
    String? name,
    bool? isSelected,
  }) {
    return MovieInterestModel(
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

