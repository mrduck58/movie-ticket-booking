import 'package:dio/dio.dart';
import 'package:movie_ticket_booking/domain/entities/seat.dart';
import '../models/checkout_response_model.dart';

/// Datasource gọi thực tế lên API Backend để tạo link PayOS và kiểm tra trạng thái đơn hàng
class CheckoutApiDatasource {
  final Dio dio;

  CheckoutApiDatasource(this.dio);

  /// Gọi POST /api/bookings/checkout
  /// Trả về [CheckoutResponseModel] chứa orderCode và checkoutUrl của PayOS
  Future<CheckoutResponseModel> createCheckoutSession({
    required String showtimeId,
    required List<Seat> seats,
    required double totalAmount,
    required int comboTotal,
  }) async {
    try {
      final body = {
        'showtimeId': showtimeId,
        'seats': seats.map((s) => {
          'seatId': s.seatId,
          'showtimeTicketTypeId': s.showtimeTicketTypeId ?? '',
        }).toList(),
        'comboTotal': comboTotal.toDouble(),
        'totalAmount': totalAmount,
      };
      // ignore: avoid_print
      print('[CheckoutAPI] Sending body: $body');

      final response = await dio.post('/api/bookings/checkout', data: body);
      return CheckoutResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      final responseBody = e.response?.data;
      String errorMsg = 'Failed to create checkout session';

      if (responseBody is Map) {
        // ASP.NET Core ValidationProblemDetails trả về { title, errors: { field: [msg] } }
        final errors = responseBody['errors'];
        if (errors is Map && errors.isNotEmpty) {
          // Nối tất cả field errors thành một chuỗi dễ đọc
          final errorDetails = errors.entries
              .map((e) => '${e.key}: ${(e.value as List).join(', ')}')
              .join('\n');
          errorMsg = errorDetails;
        } else {
          errorMsg = responseBody['message']?.toString() ??
              responseBody['title']?.toString() ??
              responseBody['error']?.toString() ??
              responseBody.toString();
        }
      } else if (responseBody is String) {
        errorMsg = responseBody;
      }

      // ignore: avoid_print
      print('[CheckoutAPI] Error ${e.response?.statusCode}: $errorMsg');
      print('[CheckoutAPI] Full response: $responseBody');
      throw Exception(errorMsg);
    }
  }

  /// Gọi GET /api/bookings/{orderCode}/status
  /// Dùng untuk polling – trả về "Pending" hoặc "Paid"
  Future<String> getPaymentStatus(int orderCode) async {
    final url = '/api/bookings/$orderCode/status';
    // ignore: avoid_print
    print('[CheckoutAPI] Getting status from: ${dio.options.baseUrl}$url');
    final response = await dio.get(url);
    // ignore: avoid_print
    print('[CheckoutAPI] Raw response: ${response.data} (type: ${response.data.runtimeType})');

    if (response.statusCode == 200) {
      final data = response.data;
      if (data is Map) {
        // Thử cả key viết hoa và viết thường
        final status = (data['status'] ?? data['Status'] ?? '').toString();
        // ignore: avoid_print
        print('[CheckoutAPI] Parsed status: "$status"');
        return status;
      }
      // ignore: avoid_print
      print('[CheckoutAPI] Data is not a Map, returning as string: "${data.toString()}"');
      return data.toString();
    } else {
      throw Exception('Failed to get payment status: ${response.statusCode}');
    }
  }
  /// Lấy thông tin booking sau khi thanh toán thành công
  Future<Map<String, dynamic>> getBookingStatus(int orderCode) async {
    final response = await dio.get('/api/bookings/$orderCode/status');
    if (response.statusCode == 200) {
      // ignore: avoid_print
      print('[CheckoutAPI] Booking Info Raw Data: ${response.data}');
      return response.data;
    }
    throw Exception('Failed to get booking status');
  }
}
