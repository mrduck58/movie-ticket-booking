import '../../domain/entities/profile.dart';

class ProfileState {

  final Profile? profile;
  final bool loading;

  ProfileState({
    this.profile,
    this.loading = false,
  });

  ProfileState copyWith({
    Profile? profile,
    bool? loading,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      loading: loading ?? this.loading,
    );
  }
}