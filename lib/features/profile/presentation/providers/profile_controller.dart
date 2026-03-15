import 'package:flutter_riverpod/legacy.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import 'profile_state.dart';

class ProfileController extends StateNotifier<ProfileState> {

  final ProfileRepository repository;

  ProfileController(this.repository) : super(ProfileState());

  Future<void> loadProfile() async {

    state = state.copyWith(loading: true);

    final profile = await repository.getProfile();

    state = state.copyWith(
      profile: profile,
      loading: false,
    );
  }

  void updateProfile(Profile profile) {
    state = state.copyWith(profile: profile);
  }
}