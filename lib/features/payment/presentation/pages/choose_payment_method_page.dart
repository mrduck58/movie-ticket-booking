import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../checkout/presentation/providers/booking_draft_provider.dart';
import '../providers/payment_providers.dart';

class ChoosePaymentMethodPage extends ConsumerWidget {
  const ChoosePaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final methods = ref.watch(paymentMethodsProvider);
    final selectedId = ref.watch(selectedPaymentIdProvider);

    final draft = ref.watch(bookingDraftProvider);

    // Tổng tiền ưu tiên lấy từ payableAmount đã set ở Review
    //final fallback = (draft.seatPrice * draft.selectedSeatIds.length).roundToDouble();
    //final payable = (draft.payableAmount > 0) ? draft.payableAmount : fallback;

    final moneyVnd =
        NumberFormat.currency(locale: 'vi_VN', symbol: 'VND', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        centerTitle: true,
        title: const Text(
          'Choose Payment Me...',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '05:42',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 110),
              children: [
                for (final m in methods) ...[
                  _PaymentTile(
                    title: m.title,
                    subtitle: m.masked,
                    leading: _paymentIcon(m.type),
                    isSelected: m.id == selectedId,
                    onTap: () => ref
                        .read(selectedPaymentIdProvider.notifier)
                        .select(m.id),
                  ),
                  const SizedBox(height: 12),
                ],
                Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF1F3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Add New Payment (mock)')),
                      );
                    },
                    icon: const Icon(Icons.add, color: AppColors.primary),
                    label: const Text(
                      'Add New Payment',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: SizedBox(
                height: 54,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: selectedId == null
                      ? null
                      : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Confirm payment with $selectedId')),
                          );
                          // TODO: navigate success/ticket screen
                        },
                  child: Text(
                    'Confirm Payment - ???',
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentIcon(PaymentType type) {
    switch (type) {
      case PaymentType.paypal:
        return const CircleAvatar(
          backgroundColor: Color(0xFFE7F0FF),
          child: Text('P',
              style: TextStyle(
                  fontWeight: FontWeight.w900, color: Color(0xFF1A4BB8))),
        );
      case PaymentType.googlePay:
        return const CircleAvatar(
          backgroundColor: Colors.white,
          child: Text('G',
              style: TextStyle(fontWeight: FontWeight.w900, color: Colors.blue)),
        );
      case PaymentType.applePay:
        return const CircleAvatar(
          backgroundColor: Colors.black,
          child: Icon(Icons.apple, color: Colors.white),
        );
      case PaymentType.card:
        return const CircleAvatar(
          backgroundColor: Colors.black,
          child: Icon(Icons.credit_card, color: Colors.white),
        );
    }
  }
}

class _PaymentTile extends StatelessWidget {
  final Widget leading;
  final String title;
  final String? subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentTile({
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.black12,
            width: isSelected ? 1.6 : 1,
          ),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              offset: Offset(0, 4),
              color: Color(0x0A000000),
            )
          ],
        ),
        child: Row(
          children: [
            leading,
            const SizedBox(width: 12),
            Expanded(
              child: Row(
                children: [
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.w800)),
                  if (subtitle != null) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        subtitle!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 10),
            if (isSelected)
              const Icon(Icons.check, color: AppColors.primary, size: 22),
          ],
        ),
      ),
    );
  }
}