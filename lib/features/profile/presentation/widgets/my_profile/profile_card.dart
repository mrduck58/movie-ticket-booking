import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/profile.dart';
import '../../pages/edit_profile.dart';
import '../../providers/profile_providers.dart';
import 'profile_list.dart';
import 'section_header.dart';

class ProfileCard extends ConsumerWidget {
  final Profile profile;

  const ProfileCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          SectionHeader(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditProfileScreen(profile: profile),
                ),
              );

              if (result != null) {
                ref
                    .read(profileControllerProvider.notifier)
                    .updateProfile(result);
              }
            },
          ),

          const Divider(height: 1),

          ProfileList(profile: profile),
        ],
      ),
    );
  }
}
