class Post {
  final int id;
  final String name;
  final DateTime time;
  final String content;
  final String? image;
  final int likes;
  final String avatar;
  Post({
    required this.id,
    required this.name,
    required this.time,
    required this.content,
    this.image,
    required this.likes,
    required this.avatar
  });

  Post copyWith({
    int? id,
    String? name,
    int? likes,
    DateTime? time,
    String? content,
    String? image,
    String? avatar,
  }) {
    return Post(
      id: id ?? this.id,
      name: name ?? this.name,
      likes: likes ?? this.likes,
      time: time ?? this.time,
      content: content ?? this.content,
      image: image ?? this.image,
      avatar: avatar ?? this.avatar,
    );
  }
}