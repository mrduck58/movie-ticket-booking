import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../domain/entities/payment_method.dart';
import '../../../../domain/repositories/payment_repository.dart';

import '../../data/datasources/payment_mock_datasource.dart';
import '../../data/repositories/payment_repository_impl.dart';

final paymentDatasourceProvider =
    Provider<PaymentMockDatasource>((ref) {
  return PaymentMockDatasourceImpl();
});

final paymentRepositoryProvider =
    Provider<PaymentRepository>((ref) {

  final ds = ref.watch(paymentDatasourceProvider);

  return PaymentRepositoryImpl(ds);
});

final paymentMethodsProvider =
    FutureProvider<List<PaymentMethod>>((ref) {

  final repo = ref.watch(paymentRepositoryProvider);

  return repo.getPaymentMethods();
});

final selectedPaymentProvider =
    StateProvider<PaymentMethod?>((ref) => null);