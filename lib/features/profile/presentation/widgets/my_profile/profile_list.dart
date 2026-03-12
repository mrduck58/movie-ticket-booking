import 'package:flutter/material.dart';
import '../../../domain/entities/profile.dart';
import 'info_row.dart';

class ProfileList extends StatelessWidget {

  final Profile profile;

  const ProfileList({
    super.key,
    required this.profile,
  });

  static const icons = [
    Icons.person_outline,
    Icons.person_outline,
    Icons.cake_outlined,
    Icons.badge_outlined,
    Icons.location_on_outlined,
    Icons.home_outlined,
    Icons.email_outlined,
  ];

  static const labels = [
    "Tên",
    "Giới tính",
    "Ngày sinh",
    "Căn cước công dân",
    "Địa chỉ",
    "Quê quán",
    "Email",
  ];

  @override
  Widget build(BuildContext context) {

    final values = [
      profile.name,
      profile.gender,
      profile.birthday,
      profile.cccd,
      profile.address,
      profile.hometown,
      profile.email,
    ];

    return Column(
      children: List.generate(labels.length, (index) {
        return InfoRow(
          icon: icons[index],
          label: labels[index],
          value: values[index],
        );
      }),
    );
  }
}