import 'package:movie_ticket_booking/features/profile/domain/entities/profile.dart';

class ProfileModel extends Profile {

  ProfileModel({
    required super.name,
    required super.gender,
    required super.birthday,
    required super.cccd,
    required super.address,
    required super.hometown,
    required super.email,
  });
  factory ProfileModel.fromEntity(Profile profile) {
  return ProfileModel(
    name: profile.name,
    gender: profile.gender,
    birthday: profile.birthday,
    cccd: profile.cccd,
    address: profile.address,
    hometown: profile.hometown,
    email: profile.email,
  );
}
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json["name"],
      gender: json["gender"]?? "Chưa cập nhật",
      birthday: json["birthday"],
      cccd: json["cccd"]?? "Chưa cập nhật",
      address: json["address"]?? "Chưa cập nhật",
      hometown: json["hometown"]?? "Chưa cập nhật",
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "gender": gender,
      "birthday": birthday,
      "cccd": cccd,
      "address": address,
      "hometown": hometown,
      "email": email,
    };
  }
}