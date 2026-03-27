import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/features/payment/presentation/providers/checkout_provider.dart';
import 'package:movie_ticket_booking/features/review/data/models/booking_success_model.dart';

/// Provider lấy thông tin chi tiết booking (bao gồm QrCodes) qua orderCode
final bookingSuccessProvider = FutureProvider.family<BookingSuccessResponse, int>((ref, orderCode) async {
  final ds = ref.watch(checkoutDatasourceProvider);
  final data = await ds.getBookingStatus(orderCode);
  return BookingSuccessResponse.fromJson(data);
});
