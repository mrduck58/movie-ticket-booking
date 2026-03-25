import '../entities/voucher.dart';

abstract class VoucherRepository {
  //Future<List<Voucher>> getVouchers();
  Future<void> applyVoucher(String voucherId);
  Future<List<Voucher>> getUserVouchers();
}