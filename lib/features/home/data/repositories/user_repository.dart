import '../datasources/user_api_datasource.dart';
import '../models/user_model.dart';

class UserRepository {
  final UserApiDatasource datasource;

  UserRepository(this.datasource);

  Future<UserModel> getCurrentUser() async {
    try {
      // Gọi xuống datasource để lấy Profile từ C#
      return await datasource.getCurrentUser();
    } catch (e) {
      // Nếu có bất kỳ lỗi nào (401, 500, không có mạng...)
      // Trả về đối tượng Guest để UI vẫn hiển thị được chữ "Khách"
      print("Lỗi lấy Profile, trả về Guest mode: $e");
      return UserModel.guest();
    }
  }
  
}