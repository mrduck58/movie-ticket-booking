import 'package:movie_ticket_booking/features/profile/data/models/profile_model.dart';
import 'package:movie_ticket_booking/features/profile/domain/entities/profile.dart';
import 'package:movie_ticket_booking/features/profile/domain/repositories/profile_repository.dart';
import '../datasources/profile_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDatasource datasource;

  ProfileRepositoryImpl(this.datasource);

  @override
  Future<Profile> getProfile() async {
    return await datasource.getProfile();
  }

  @override
  Future<void> updateProfile(Profile profile) async {
    // mock nên chưa lưu
    final model = ProfileModel.fromEntity(profile);
    await datasource.updateProfile(model);
  }
}
