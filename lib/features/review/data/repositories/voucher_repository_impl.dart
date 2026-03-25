import 'package:movie_ticket_booking/domain/entities/voucher.dart';
import 'package:movie_ticket_booking/domain/repositories/voucher_repository.dart';
import '../datasources/voucher_api_datasource.dart';

class VoucherRepositoryImpl implements VoucherRepository {
  final VoucherApiDatasource datasource;

  VoucherRepositoryImpl(this.datasource);

  @override
  Future<List<Voucher>> getUserVouchers() {
    return datasource.getUserVouchers();
  }

  @override
  Future<void> applyVoucher(String voucherId) {
    return datasource.applyVoucher(voucherId);
  }
}