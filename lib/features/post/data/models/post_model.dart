import '../../domain/entities/post.dart';

class PostModel extends Post {
  PostModel({
    required super.id,
    required super.name,
    required super.time,
    required super.content,
    super.image,
    required super.likes,
    required super.avatar
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json["id"],
      name: json["name"],
      time: DateTime.parse(json['created_at']),
      content: json["content"],
      image: json["image"],
      likes: json["likes"],
      avatar: json["avatar"]
    );
  }
  
}