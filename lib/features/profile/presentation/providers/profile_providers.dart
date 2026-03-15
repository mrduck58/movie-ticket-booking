import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:movie_ticket_booking/features/profile/data/datasources/profile_datasource.dart';
import 'package:movie_ticket_booking/features/profile/data/repositories/profile_repository_impl.dart';
import '../../domain/repositories/profile_repository.dart';
import 'profile_controller.dart';
import 'profile_state.dart';

final profileDatasourceProvider =
    Provider((ref) => ProfileDatasource());

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl(ref.read(profileDatasourceProvider));
});

final profileControllerProvider =
    StateNotifierProvider<ProfileController, ProfileState>((ref) {
  return ProfileController(ref.read(profileRepositoryProvider));
});