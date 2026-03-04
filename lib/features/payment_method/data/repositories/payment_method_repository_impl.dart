import '../../domain/entities/payment_method.dart';
import '../../domain/repositories/payment_method_repository.dart';
import '../datasources/payment_method_local_datasource.dart';
import '../models/payment_method_model.dart';

class PaymentMethodRepositoryImpl implements PaymentMethodRepository {
  final PaymentMethodLocalDataSource local;
  PaymentMethodRepositoryImpl(this.local);

  @override
  Future<List<PaymentMethod>> getMethods() async {
    final list = await local.getMethodsWithCache();
    return List<PaymentMethod>.from(list);
  }

  @override
  Future<String?> getSelectedId() => local.getSelectedIdWithCache();

  @override
  Future<void> setSelectedId(String id) => local.setSelectedId(id);

  @override
  Future<void> addMethod(PaymentMethod method) {
    final m = PaymentMethodModel(id: method.id, type: method.type, title: method.title);
    return local.addMethod(m);
  }
}