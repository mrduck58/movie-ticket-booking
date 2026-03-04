class ComboModel {
  final String id;
  final String name;
  final int priceVnd;
  final String imageUrl;

  const ComboModel({
    required this.id,
    required this.name,
    required this.priceVnd,
    required this.imageUrl,
  });

  factory ComboModel.fromJson(Map<String, dynamic> json) {
    return ComboModel(
      id: json['id'] as String,
      name: json['name'] as String,
      priceVnd: (json['priceVnd'] as num).toInt(),
      imageUrl: json['imageUrl'] as String,
    );
  }
}