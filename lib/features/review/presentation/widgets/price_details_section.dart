import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/core/theme/app_colors.dart';
import 'package:movie_ticket_booking/core/constants/app_constant.dart';
import 'package:movie_ticket_booking/core/utils/formatters/money_formatter.dart';

class PriceDetailsSection extends StatelessWidget {
  final int ticketPrice;
  final int ticketCount;
  final int comboPrice;
  final int voucher;
  final int total;

  const PriceDetailsSection({
    super.key,
    required this.ticketPrice,
    required this.ticketCount,
    required this.comboPrice,
    required this.voucher,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final ticketTotal = ticketPrice * ticketCount;

    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        color: AppColors.surface,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text(
            "Price Details",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),

          const SizedBox(height: 6),

          const Divider(),

          const SizedBox(height: 6),

          _row("Standard (x$ticketCount)", MoneyFormatter.vnd(ticketTotal)),

          if (comboPrice > 0)
            _row("Food Combo", MoneyFormatter.vnd(comboPrice)),

          _row("Voucher", "-${MoneyFormatter.vnd(voucher)}"),

          const Divider(),

          _row("Actual Pay", MoneyFormatter.vnd(total), highlight: true),
        ],
      ),
    );
  }

  Widget _row(String label, String value, {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
              fontSize: 16
            ),
          ),

          Text(
            value,
            style: TextStyle(
              color: highlight ? AppColors.primary : null,
              fontWeight: highlight ? FontWeight.w700 : FontWeight.w600,
              fontSize: highlight ? 18 : 16,
            ),
          ),
        ],
      ),
    );
  }
}
