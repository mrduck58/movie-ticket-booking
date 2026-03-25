import '../../domain/entities/user_profile.dart';

class AccountState {
  final UserProfile user;

  const AccountState({
    required this.user,
  });

  AccountState copyWith({
    UserProfile? user,
  }) {
    return AccountState(
      user: user ?? this.user,
    );
  }
}