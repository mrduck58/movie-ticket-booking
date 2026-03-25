import '../../../../domain/entities/combo.dart';

class ComboModel extends Combo {
  const ComboModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.image,
  });

  factory ComboModel.fromJson(Map<String, dynamic> json) {
    return ComboModel(
      id: json['foodComboId'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toInt(),
      image: json['imageUrl'] as String,
    );
  }
}