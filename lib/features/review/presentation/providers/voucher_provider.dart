import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/datasources/voucher_mock_datasource.dart';
import '../../../../domain/entities/voucher.dart';

final vouchersProvider = FutureProvider<List<Voucher>>((ref) async {
  final datasource = VoucherMockDatasource();
  return datasource.getVouchers();
});

final selectedVoucherProvider =
    StateProvider<Voucher?>((ref) => null);