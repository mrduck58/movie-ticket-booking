import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/payment_method_local_datasource.dart';
import '../../data/repositories/payment_method_repository_impl.dart';
import '../../domain/repositories/payment_method_repository.dart';
import 'payment_method_controller.dart';
import 'payment_method_state.dart';

final paymentMethodLocalDataSourceProvider =
    Provider((ref) => PaymentMethodLocalDataSource());

final paymentMethodRepositoryProvider = Provider<PaymentMethodRepository>((ref) {
  return PaymentMethodRepositoryImpl(ref.read(paymentMethodLocalDataSourceProvider));
});

final paymentMethodControllerProvider =
    AsyncNotifierProvider<PaymentMethodController, PaymentMethodState>(
  PaymentMethodController.new,
);