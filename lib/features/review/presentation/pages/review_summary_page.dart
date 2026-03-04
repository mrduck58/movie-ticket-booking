import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../checkout/presentation/providers/booking_draft_provider.dart';
import '../providers/review_providers.dart';

class ReviewSummaryPage extends ConsumerWidget {
  const ReviewSummaryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.watch(bookingDraftProvider);
    final combosAsync = ref.watch(combosProvider);

    final moneyVnd =
        NumberFormat.currency(locale: 'vi_VN', symbol: 'VND', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text('Review Summary',
            style: TextStyle(fontWeight: FontWeight.w700)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text('01:23',
                  style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800)),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: combosAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (combos) {
            // combo total
            int comboTotalVnd = 0;
            for (final c in combos) {
              final qty = draft.comboQty[c.id] ?? 0;
              comboTotalVnd += c.priceVnd * qty;
            }

            // seats total (đang dùng seatPrice như VND)
            final seatsTotalVnd =
                (draft.seatPrice * draft.selectedSeatIds.length).round();
            final voucherVnd = draft.voucherDiscount.round();

            final actualPayVnd =
                (seatsTotalVnd + comboTotalVnd - voucherVnd).clamp(0, 1 << 31);

            return Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 110),
                  children: [
                    // Top movie info (demo)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: 84,
                            height: 120,
                            color: Colors.black12,
                            alignment: Alignment.center,
                            child: const Text('Poster'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Jujutsu Kaisen',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900)),
                              const SizedBox(height: 8),
                              const Text('Duration : 134 minutes',
                                  style: TextStyle(color: Colors.black54)),
                              const SizedBox(height: 4),
                              const Text('Director : Nia DaCosta',
                                  style: TextStyle(color: Colors.black54)),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Text('AR : ',
                                      style:
                                          TextStyle(color: Colors.black54)),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border:
                                          Border.all(color: AppColors.primary),
                                    ),
                                    child: const Text('R13+',
                                        style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w800)),
                                  )
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Genre : Action, Fantasy,\nAdventure, Science Fiction,\nSuperhero',
                                style: TextStyle(
                                    color: Colors.black54, height: 1.3),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    _CardBox(
                      title: 'Booking Details',
                      child: Column(
                        children: [
                          _kv('Cinema', draft.cinemaId ?? '-'),
                          _kv('Package', draft.format ?? '-'),
                          _kv('Auditorium', 'Auditorium 3'),
                          _kv('Seat(s)',
                              draft.selectedSeatIds.isEmpty
                                  ? '-'
                                  : draft.selectedSeatIds.join(', ')),
                          _kv(
                            'Date',
                            draft.date == null
                                ? '-'
                                : DateFormat('MMM dd, yyyy')
                                    .format(draft.date!),
                          ),
                          _kv('Hours',
                              draft.time == null ? '-' : '${draft.time} - 20:38'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    _CardBox(
                      title: 'Food Combo Details',
                      child: Column(
                        children: combos.map((c) {
                          final qty = draft.comboQty[c.id] ?? 0;
                          return _ComboRow(
                            name: c.name,
                            priceText: moneyVnd.format(c.priceVnd),
                            qty: qty,
                            onMinus: () => ref
                                .read(bookingDraftProvider.notifier)
                                .setComboQty(c.id, qty - 1),
                            onPlus: () => ref
                                .read(bookingDraftProvider.notifier)
                                .setComboQty(c.id, qty + 1),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 12),

                    _CardBox(
                      title: 'Promo & Vouchers',
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter the promo code or voucher',
                          filled: true,
                          fillColor: const Color(0xFFF4F4F4),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onSubmitted: (code) {
                          if (code.trim().toUpperCase() == 'SAVE10') {
                            ref
                                .read(bookingDraftProvider.notifier)
                                .setVoucherDiscount(10000);
                          } else {
                            ref
                                .read(bookingDraftProvider.notifier)
                                .setVoucherDiscount(0);
                          }
                        },
                      ),
                    ),

                    const SizedBox(height: 12),

                    _CardBox(
                      title: 'Price Details',
                      child: Column(
                        children: [
                          _priceRow(
                            'Standard (x${draft.selectedSeatIds.length})',
                            moneyVnd.format(seatsTotalVnd),
                          ),
                          _priceRow(
                            'Food Combo (total)',
                            moneyVnd.format(comboTotalVnd),
                          ),
                          _priceRow('Voucher', moneyVnd.format(voucherVnd)),
                          const Divider(),
                          _priceRow(
                            'Actual Pay',
                            moneyVnd.format(actualPayVnd),
                            isTotal: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: SizedBox(
                    height: 52,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () {
                        // Lưu tổng tiền cuối cùng vào draft
                        ref
                            .read(bookingDraftProvider.notifier)
                            .setPayableAmount(actualPayVnd.toDouble());

                        // Sang màn chọn phương thức thanh toán
                        context.go('/payment-method');
                      },
                      child: const Text('Continue to Payment',
                          style: TextStyle(fontWeight: FontWeight.w900)),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _kv(String k, String v) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(k,
                style: const TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(v,
                textAlign: TextAlign.right,
                style: const TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Widget _priceRow(String title, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(title,
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight:
                        isTotal ? FontWeight.w800 : FontWeight.w600)),
          ),
          const SizedBox(width: 12),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.w900 : FontWeight.w700,
              color: isTotal ? AppColors.primary : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class _CardBox extends StatelessWidget {
  final String title;
  final Widget child;
  const _CardBox({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _ComboRow extends StatelessWidget {
  final String name;
  final String priceText;
  final int qty;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  const _ComboRow({
    required this.name,
    required this.priceText,
    required this.qty,
    required this.onMinus,
    required this.onPlus,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black12),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.fastfood_outlined),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 2),
                Text(priceText,
                    style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Row(
            children: [
              _QtyButton(icon: Icons.remove, onTap: qty <= 0 ? null : onMinus),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text('x$qty',
                    style: const TextStyle(fontWeight: FontWeight.w900)),
              ),
              _QtyButton(icon: Icons.add, onTap: onPlus),
            ],
          ),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 34,
      height: 34,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          side: const BorderSide(color: Colors.black12),
        ),
        onPressed: onTap,
        child: Icon(icon, size: 18),
      ),
    );
  }
}