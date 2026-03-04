import '../../domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  UserProfileModel({
    required super.name,
    required super.email,
    required super.avatar,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'] ?? "",
    );
  }
}