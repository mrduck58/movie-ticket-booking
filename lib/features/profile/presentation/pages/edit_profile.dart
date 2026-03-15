import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/features/profile/presentation/widgets/update_profile/edit_profile_form.dart';
import '../../domain/entities/profile.dart';
import '../providers/profile_providers.dart';

class EditProfileScreen extends ConsumerWidget {
  final Profile profile;

  const EditProfileScreen({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffF8D7DA),
        title: const Text(
          "Chỉnh sửa thông tin",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),  

      body: EditProfileForm(
        profile: profile,
        onSave: (updatedProfile) {

          /// cập nhật state
          ref
              .read(profileControllerProvider.notifier)
              .updateProfile(updatedProfile);

          /// quay lại màn hình profile
          Navigator.pop(context);
        },
      ),
    );
  }
}