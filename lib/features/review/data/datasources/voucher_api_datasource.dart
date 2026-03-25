import 'package:dio/dio.dart';
import '../models/voucher_model.dart';

class VoucherApiDatasource {
  final Dio dio;

  VoucherApiDatasource(this.dio);

  /// Lấy voucher của user
  Future<List<VoucherModel>> getUserVouchers() async {
    final response = await dio.get('/vouchers/my');

    final List data = response.data;

    return data
        .map((e) => VoucherModel.fromJson(e))
        .toList();
  }

  /// Apply voucher
  Future<void> applyVoucher(String voucherId) async {
    await dio.post('/vouchers/apply/$voucherId');
  }
}