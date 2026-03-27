import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../checkout/providers/booking_draft_provider.dart';
import '../../../food_combo/presentation/providers/combo_provider.dart';
import '../../../review/presentation/providers/booking_expiry_provider.dart';
import '../../../review/presentation/widgets/booking_countdown_app_badge.dart';
import '../../../seat_selection/presentation/providers/seat_providers.dart';
import '../providers/checkout_provider.dart';
import '../providers/payment_providers.dart';

class PaymentWaitingPage extends ConsumerStatefulWidget {
  const PaymentWaitingPage({super.key});

  @override
  ConsumerState<PaymentWaitingPage> createState() => _PaymentWaitingPageState();
}

class _PaymentWaitingPageState extends ConsumerState<PaymentWaitingPage> {
  bool _isChecking = false;
  String? _statusMessage;

  @override
  void initState() {
    super.initState();
    // Lắng nghe đếm ngược hết hạn → chuyển sang expired
    ref.listenManual(bookingExpiryProvider, (previous, next) {
      if (next.isExpired && mounted) {
        context.go('/booking-expired');
      }
    });
  }

  Future<void> _checkStatus() async {
    if (_isChecking) return;
    setState(() {
      _isChecking = true;
      _statusMessage = null;
    });

    try {
      final paid = await ref.read(paymentFlowProvider.notifier).checkPaymentStatus();

      if (!mounted) return;

      if (paid) {
        _navigateToSuccess();
      } else {
        setState(() {
          _isChecking = false;
          _statusMessage = 'Payment not received yet. Please try again in a moment.';
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isChecking = false;
        _statusMessage = 'Connection error: $e';
      });
    }
  }

  void _navigateToSuccess() {
    final orderId = ref.read(paymentFlowProvider).orderCode?.toString() ?? 'SUCCESS';

    // Dừng timer
    ref.read(bookingExpiryProvider.notifier).stop();
    // KHÔNG reset draft ở đây để BookingDetailPage vẫn đọc được thông tin
    // Draft sẽ được reset khi user rời khỏi BookingDetailPage

    if (mounted) {
      context.go('/booking-detail/$orderId');
    }
  }

  Future<void> _reopenPayosLink() async {
    final url = ref.read(paymentFlowProvider).checkoutUrl;
    if (url == null) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final flowState = ref.watch(paymentFlowProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Waiting for Payment',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        actions: const [
          BookingCountdownAppbarBadge(),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.qr_code_scanner_rounded,
                size: 60,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 32),

            const Text(
              'Scan QR to Pay',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Open your banking app and scan the QR code.\nAfter payment, click the button below to confirm.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),

            const SizedBox(height: 32),

            // Mở lại link PayOS
            if (flowState.checkoutUrl != null)
              OutlinedButton.icon(
                onPressed: _reopenPayosLink,
                icon: const Icon(Icons.open_in_browser),
                label: const Text('Open Payment Page'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),

            const SizedBox(height: 16),

            // Thông báo trạng thái (nếu có)
            if (_statusMessage != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.shade300),
                ),
                child: Text(
                  _statusMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.orange, fontSize: 13),
                ),
              ),

            if (_statusMessage != null) const SizedBox(height: 16),

            // Nút "Tôi đã thanh toán"
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isChecking ? null : _checkStatus,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: _isChecking
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Checking...',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      )
                    : const Text(
                        'I have already paid',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
