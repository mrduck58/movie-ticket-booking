import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:movie_ticket_booking/domain/entities/voucher.dart';
import 'package:movie_ticket_booking/domain/repositories/voucher_repository.dart';
import 'package:movie_ticket_booking/features/review/data/datasources/voucher_api_datasource.dart';
import 'package:movie_ticket_booking/features/review/data/models/voucher_model.dart';
import 'package:movie_ticket_booking/features/review/data/repositories/voucher_repository_impl.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: 'https://localhost:7132/api',
    ),
  );
});

final voucherDatasourceProvider = Provider<VoucherApiDatasource>((ref) {
  final dio = ref.watch(dioProvider);
  return VoucherApiDatasource(dio);
});

final voucherRepositoryProvider = Provider<VoucherRepository>((ref) {
  final datasource = ref.watch(voucherDatasourceProvider);
  return VoucherRepositoryImpl(datasource);
});

final vouchersProvider = FutureProvider<List<Voucher>>((ref) async {
  final repo = ref.watch(voucherRepositoryProvider);
  return repo.getUserVouchers();
});

final applyVoucherProvider =
    FutureProvider.family<void, String>((ref, voucherId) async {
  final repo = ref.watch(voucherRepositoryProvider);
  await repo.applyVoucher(voucherId);
});

/// selected voucher
final selectedVoucherProvider =
    StateProvider<Voucher?>((ref) => null);