class UserModel {
  final String name;
  final String avatarUrl;

  UserModel({
    required this.name,
    required this.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['fullName'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
    );
  }
}