class PostLikeModel {
  final String postId;
  final bool isLiked;

  PostLikeModel({
    required this.postId,
    required this.isLiked,
  });

  factory PostLikeModel.fromJson(Map<String, dynamic> json) {
    return PostLikeModel(
      postId: json['postId'],
      isLiked: json['isLiked'],
    );
  }
}