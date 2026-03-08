import '../../domain/entities/post_comment.dart';

class PostCommentModel extends PostComment {
  PostCommentModel({
    required super.name,
    required super.content,
  });

  factory PostCommentModel.fromJson(Map<String, dynamic> json) {
    return PostCommentModel(
      name: json['name'],
      content: json['content'],
    );
  }
}