import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/profile_providers.dart';
import '../widgets/my_profile/profile_card.dart';

class ProfileInfoScreen extends ConsumerStatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  ConsumerState<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends ConsumerState<ProfileInfoScreen> {

  @override
  void initState() {
    super.initState();

    /// gọi load data khi mở màn hình
    Future.microtask(() {
      ref.read(profileControllerProvider.notifier).loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(profileControllerProvider);

    if (state.loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.profile == null) {
      return const Scaffold(
        body: Center(child: Text("Không có dữ liệu")),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xffF3F3F3),

      appBar: AppBar(
        backgroundColor: const Color(0xffF8D7DA),
        elevation: 0,
        title: const Text(
          "Thông tin về bạn",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ProfileCard(profile: state.profile!),
      ),
    );
  }
}