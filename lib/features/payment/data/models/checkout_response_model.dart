/// Model chứa dữ liệu trả về từ API tạo link thanh toán PayOS
class CheckoutResponseModel {
  final int orderCode;
  final String checkoutUrl;

  CheckoutResponseModel({
    required this.orderCode,
    required this.checkoutUrl,
  });

  factory CheckoutResponseModel.fromJson(Map<String, dynamic> json) {
    return CheckoutResponseModel(
      orderCode: (json['orderCode'] as num).toInt(),
      checkoutUrl: json['checkoutUrl'] as String,
    );
  }
}
