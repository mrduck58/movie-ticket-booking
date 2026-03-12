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

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json["name"],
      gender: json["gender"],
      birthday: json["birthday"],
      cccd: json["cccd"],
      address: json["address"],
      hometown: json["hometown"],
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