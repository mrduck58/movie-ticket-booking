import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/features/profile/domain/entities/profile.dart';
import 'package:movie_ticket_booking/features/profile/presentation/providers/profile_providers.dart';
import 'package:movie_ticket_booking/features/profile/presentation/widgets/update_profile/birthday_picker.dart';
import 'package:movie_ticket_booking/features/profile/presentation/widgets/update_profile/cccd_field.dart';
import 'package:movie_ticket_booking/features/profile/presentation/widgets/update_profile/email_field.dart';
import 'package:movie_ticket_booking/features/profile/presentation/widgets/update_profile/gender_dropdown.dart';
import 'package:movie_ticket_booking/features/profile/presentation/widgets/update_profile/name_field.dart';
import 'package:movie_ticket_booking/features/profile/presentation/widgets/update_profile/province_dropdown.dart';

class EditProfileForm extends ConsumerStatefulWidget {
  final Profile profile;

  const EditProfileForm({
    super.key,
    required this.profile,
  });

  @override
  ConsumerState<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends ConsumerState<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController genderController;
  late final TextEditingController birthdayController;
  late final TextEditingController cccdController;
  late final TextEditingController addressController;
  late final TextEditingController hometownController;
  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();

    final p = widget.profile;

    nameController = TextEditingController(text: p.name);
    genderController = TextEditingController(text: p.gender);
    birthdayController = TextEditingController(text: p.birthday);
    cccdController = TextEditingController(text: p.cccd);
    addressController = TextEditingController(text: p.address);
    hometownController = TextEditingController(text: p.hometown);
    emailController = TextEditingController(text: p.email);
  }

  @override
  void dispose() {
    nameController.dispose();
    genderController.dispose();
    birthdayController.dispose();
    cccdController.dispose();
    addressController.dispose();
    hometownController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final updatedProfile = Profile(
      name: nameController.text.trim(),
      gender: genderController.text.trim(),
      birthday: birthdayController.text.trim(),
      cccd: cccdController.text.trim(),
      address: addressController.text.trim(),
      hometown: hometownController.text.trim(),
      email: emailController.text.trim(),
    );

    try {
      await ref
          .read(profileControllerProvider.notifier)
          .updateProfile(updatedProfile);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cập nhật thành công')),
      );

      Navigator.pop(context); // quay lại
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cập nhật thất bại')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileControllerProvider);

    return Stack(
      children: [
        Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildInfoCard(),
              const SizedBox(height: 30),
              _buildSaveButton(),
            ],
          ),
        ),

        /// 🔥 loading overlay
        if (state.loading)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          NameField(controller: nameController),
          const SizedBox(height: 16),

          GenderDropdown(
            value: genderController.text,
            onChanged: (value) => genderController.text = value,
          ),

          const SizedBox(height: 16),

          BirthdayPicker(controller: birthdayController),

          const SizedBox(height: 16),

          CccdField(controller: cccdController),

          const SizedBox(height: 16),

          ProvinceDropdown(
            label: "Địa chỉ",
            value: addressController.text,
            onChanged: (value) => addressController.text = value,
          ),

          const SizedBox(height: 16),

          ProvinceDropdown(
            label: "Quê quán",
            value: hometownController.text,
            onChanged: (value) => hometownController.text = value,
          ),

          const SizedBox(height: 16),

          EmailField(controller: emailController),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      onPressed: saveProfile,
      child: const Text(
        "Lưu thông tin",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}