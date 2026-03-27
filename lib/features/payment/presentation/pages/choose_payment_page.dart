import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:movie_ticket_booking/core/utils/formatters/money_formatter.dart';
import 'package:movie_ticket_booking/features/review/presentation/providers/booking_expiry_provider.dart';
import 'package:movie_ticket_booking/features/review/presentation/widgets/booking_countdown_app_badge.dart';

import '../../../checkout/providers/booking_draft_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

import '../providers/payment_providers.dart';
import '../providers/checkout_provider.dart';
import '../widgets/payment_item.dart';
import 'payment_waiting_page.dart';

class ChoosePaymentPage extends ConsumerStatefulWidget {
  const ChoosePaymentPage({super.key});

  @override
  ConsumerState<ChoosePaymentPage> createState() => _ChoosePaymentPageState();
}

class _ChoosePaymentPageState extends ConsumerState<ChoosePaymentPage> {
  @override
  void initState() {
    super.initState();

    ref.listenManual(bookingExpiryProvider, (previous, next) {
      if (next.isExpired && mounted) {
        context.go('/booking-expired');
      }
    });
  }

  Future<void> _onConfirmPayment() async {
    final selected = ref.read(selectedPaymentProvider);
    final draft = ref.read(bookingDraftProvider);
    final showtimeId = draft.showtime?.showtimeId;
    final seatIds = draft.seats.map((s) => s.seatId).toList();
    final totalAmount = draft.totalPrice ?? 0;

    if (showtimeId == null || seatIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Missing booking information')),
      );
      return;
    }

    if (selected?.id == 'payos') {
      // Gọi API tạo checkout session → lấy link PayOS
      final result = await ref
          .read(paymentFlowProvider.notifier)
          .createCheckout(
            showtimeId: showtimeId,
            seats: draft.seats,
            totalAmount: totalAmount.toDouble(),
            comboTotal: 0, // comboTotal đã được tính vào totalAmount
          );

      if (!mounted) return;

      final flowState = ref.read(paymentFlowProvider);

      if (result == null || flowState.status == PaymentFlowStatus.failed) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(flowState.errorMessage ?? 'Failed to create payment'),
          ),
        );
        return;
      }

      // Mở link PayOS trên trình duyệt
      final uri = Uri.parse(result.checkoutUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }

      // Chuyển sang màn chờ QR được quét
      if (mounted) {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const PaymentWaitingPage()));
      }
    } else {
      // Xử lý các phương thức khác nếu có (hiện tại chỉ có PayOS)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Phương thức thanh toán này hiện chưa hỗ trợ'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final methodsAsync = ref.watch(paymentMethodsProvider);
    final selected = ref.watch(selectedPaymentProvider);
    final flowState = ref.watch(paymentFlowProvider);

    final draft = ref.watch(bookingDraftProvider);
    final price = draft.totalPrice ?? 0;

    final bool isLoading = flowState.status == PaymentFlowStatus.loading;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
              onPressed: () => context.pop(),
            ),
            title: const Text(
              'Choose Payment Method',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            actions: const [BookingCountdownAppbarBadge(), SizedBox(width: 16)],
          ),
        ),
      ),
      body: methodsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (methods) {
          return Padding(
            padding: const EdgeInsets.all(AppSpacing.pagePadding),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: methods.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final method = methods[index];
                      return PaymentItem(
                        method: method,
                        selected: selected?.id == method.id,
                        onTap: () {
                          ref.read(selectedPaymentProvider.notifier).state =
                              method;
                          ref
                              .read(bookingDraftProvider.notifier)
                              .setPayment(method.id);
                        },
                      );
                    },
                  ),
                ),

                // const SizedBox(height: 12),

                // Container(
                //   height: 50,
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(50),
                //     color: const Color.fromARGB(255, 255, 229, 229),
                //   ),
                //   child: const Center(
                //     child: Text(
                //       '+  Add New Payment',
                //       style: TextStyle(
                //         color: AppColors.primary,
                //         fontWeight: FontWeight.w600,
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    // Disable nếu chưa chọn method hoặc đang loading
                    onPressed: (selected == null || isLoading)
                        ? null
                        : _onConfirmPayment,
                    child: isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Confirm Payment - ${MoneyFormatter.vnd(price)}',
                            style: const TextStyle(
                              color: AppColors.onPrimary,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
