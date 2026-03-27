import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:movie_ticket_booking/domain/entities/seat.dart';
import 'package:movie_ticket_booking/features/payment/data/datasources/checkout_api_datasource.dart';
import 'package:movie_ticket_booking/features/payment/data/models/checkout_response_model.dart';
import 'package:movie_ticket_booking/features/seat_selection/presentation/providers/seat_providers.dart';

/// Tái sử dụng dioProvider (đã có AuthInterceptor) từ seat_providers
final checkoutDatasourceProvider = Provider<CheckoutApiDatasource>((ref) {
  final dio = ref.watch(dioProvider);
  return CheckoutApiDatasource(dio);
});

// ---------- State ----------

enum PaymentFlowStatus { idle, loading, waitingQr, paid, failed }

class PaymentFlowState {
  final PaymentFlowStatus status;
  final String? checkoutUrl;
  final int? orderCode;
  final String? errorMessage;

  const PaymentFlowState({
    this.status = PaymentFlowStatus.idle,
    this.checkoutUrl,
    this.orderCode,
    this.errorMessage,
  });

  PaymentFlowState copyWith({
    PaymentFlowStatus? status,
    String? checkoutUrl,
    int? orderCode,
    String? errorMessage,
  }) {
    return PaymentFlowState(
      status: status ?? this.status,
      checkoutUrl: checkoutUrl ?? this.checkoutUrl,
      orderCode: orderCode ?? this.orderCode,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// ---------- Notifier ----------

class PaymentFlowNotifier extends StateNotifier<PaymentFlowState> {
  final CheckoutApiDatasource _datasource;

  PaymentFlowNotifier(this._datasource) : super(const PaymentFlowState());

  /// Gọi Backend → tạo đơn hàng + nhận link PayOS
  Future<CheckoutResponseModel?> createCheckout({
    required String showtimeId,
    required List<Seat> seats,
    required double totalAmount,
    required int comboTotal,
  }) async {
    state = state.copyWith(status: PaymentFlowStatus.loading);
    try {
      final result = await _datasource.createCheckoutSession(
        showtimeId: showtimeId,
        seats: seats,
        totalAmount: totalAmount,
        comboTotal: comboTotal,
      );
      state = state.copyWith(
        status: PaymentFlowStatus.waitingQr,
        checkoutUrl: result.checkoutUrl,
        orderCode: result.orderCode,
      );
      return result;
    } catch (e) {
      state = state.copyWith(
        status: PaymentFlowStatus.failed,
        errorMessage: e.toString(),
      );
      return null;
    }
  }

  /// Polling: hỏi backend xem đơn hàng đã Paid chưa
  Future<bool> checkPaymentStatus() async {
    final orderCode = state.orderCode;
    if (orderCode == null) return false;
    try {
      final status = await _datasource.getPaymentStatus(orderCode);
      // Backend trả về status (PAID hoặc BOOKED)
      final normalizedStatus = status.toUpperCase();
      if (normalizedStatus == 'PAID' || normalizedStatus == 'BOOKED') {
        state = state.copyWith(status: PaymentFlowStatus.paid);
        return true;
      }
      return false;
    } catch (e, stack) {
      // ignore: avoid_print
      print('[CheckStatus ERROR] Exception: $e');
      // ignore: avoid_print
      print('[CheckStatus ERROR] Stack: $stack');
      return false;
    }
  }

  void reset() {
    state = const PaymentFlowState();
  }
}

// ---------- Provider ----------

final paymentFlowProvider =
    StateNotifierProvider<PaymentFlowNotifier, PaymentFlowState>((ref) {
  final ds = ref.watch(checkoutDatasourceProvider);
  return PaymentFlowNotifier(ds);
});
