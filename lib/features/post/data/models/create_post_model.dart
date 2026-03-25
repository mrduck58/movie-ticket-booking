import 'package:movie_ticket_booking/features/post/domain/entities/create_post.dart';

class CreatePostModel {
  final String content;

  CreatePostModel({
    required this.content,
  });

  // Convert từ Entity → Model
  factory CreatePostModel.fromEntity(CreatePost entity) {
    return CreatePostModel(
      content: entity.content,
    );
  }
  CreatePost toEntity(){
    return CreatePost(content: content);
  }
  // Convert sang JSON để gọi API
  Map<String, dynamic> toJson() {
    return {
      "content": content,
    };
  }
}