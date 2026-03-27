class UserModel {
  final String name;
  final String avatarUrl;

  UserModel({
    required this.name,
    required this.avatarUrl,
  });
  factory UserModel.guest() {
    return UserModel(
      name: 'Khách',
      avatarUrl: '', // Để trống để hiện Icon mặc định
    );
  }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['fullName'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
    );
  }
}