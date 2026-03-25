import '../../domain/entities/post_comment.dart';

class PostCommentModel extends PostComment {
  PostCommentModel({
    required super.id,
    required super.name,
    required super.avatar,
    required super.content,
  });

  factory PostCommentModel.fromJson(Map<String, dynamic> json) {
    return PostCommentModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
      content: json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "avatar": avatar,
      "content": content,
    };
  }

  PostComment toEntity() {
    return PostComment(
      id: id,
      name: name,
      avatar: avatar,
      content: content,
    );
  }
}