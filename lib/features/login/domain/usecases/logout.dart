import 'package:movie_ticket_booking/features/login/domain/repositories/login_repository.dart';

class Logout {
  final LoginRepository repository;

  Logout(this.repository);

  Future<void> call() async {
    await repository.logout();
  }
}