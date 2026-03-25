
abstract class CartComboRepository {
  Future<void> addComboToCart(String comboId, int quantity);
  Future<void> removeComboFromCart(String comboId);
  Future<void> updateComboQuantity(String comboId, int quantity);
}