import '../entities/payment_method.dart';

abstract class PaymentMethodRepository {
  Future<List<PaymentMethod>> getMethods();
  Future<String?> getSelectedId();

  Future<void> setSelectedId(String id);

  // demo: add new card
  Future<void> addMethod(PaymentMethod method);
}