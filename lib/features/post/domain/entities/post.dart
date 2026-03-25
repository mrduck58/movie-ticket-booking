class Post {
  final String id;
  final String name;
  final DateTime time;
  final String content;
  final String? image;
  final int likes;
  final String avatar;
  final bool isLiked;
  Post({
    required this.id,
    required this.name,
    required this.time,
    required this.content,
    this.image,
    required this.likes,
    required this.avatar,
    required this.isLiked
  });

  Post copyWith({
    String? id,
    String? name,
    int? likes,
    DateTime? time,
    String? content,
    String? image,
    String? avatar,
    bool? isLiked,
  }) {
    return Post(
      id: id ?? this.id,
      name: name ?? this.name,
      likes: likes ?? this.likes,
      time: time ?? this.time,
      content: content ?? this.content,
      image: image ?? this.image,
      avatar: avatar ?? this.avatar,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}