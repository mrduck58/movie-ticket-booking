import '../../../../domain/entities/payment_method.dart';
import '../../../../domain/repositories/payment_repository.dart';

import '../datasources/payment_mock_datasource.dart';

class PaymentRepositoryImpl implements PaymentRepository {

  final PaymentMockDatasource datasource;

  PaymentRepositoryImpl(this.datasource);

  @override
  Future<List<PaymentMethod>> getPaymentMethods() async {

    final models = await datasource.getPaymentMethods();

    return models.map((e) => e.toEntity()).toList();
  }
}