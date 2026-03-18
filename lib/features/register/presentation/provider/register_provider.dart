import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/network/dio_client.dart';
import '../../data/datasources/register_remote_datasource.dart';
import '../../data/models/register_request_model.dart';
import '../../data/repositories/register_repository_impl.dart';

/// 👇 DÙNG TRỰC TIẾP DioClient có sẵn (bạn đã có ở project)
final registerRepositoryProvider = Provider((ref) {
  final dioClient = DioClient(baseUrl: "https://localhost:7132");
  // 👆 nếu project bạn đã có provider riêng thì thay dòng này bằng ref.read(...)

  return RegisterRepositoryImpl(
    RegisterRemoteDataSource(dioClient),
  );
});

final registerProvider =
    StateNotifierProvider<RegisterNotifier, AsyncValue<void>>((ref) {
  return RegisterNotifier(ref.read(registerRepositoryProvider));
});

class RegisterNotifier extends StateNotifier<AsyncValue<void>> {
  final RegisterRepositoryImpl repo;

  RegisterNotifier(this.repo) : super(const AsyncData(null));

  Future<void> register(RegisterRequestModel model) async {
    state = const AsyncLoading();

    try {
      await repo.register(model);
      state = const AsyncData(null);
    } catch (e, st) {
      print(e);
      state = AsyncError(e, st);
    }
  }
}