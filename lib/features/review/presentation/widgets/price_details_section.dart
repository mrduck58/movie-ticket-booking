import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/core/theme/app_colors.dart';

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
        border: Border.all(color: Colors.grey.shade300),
        color: AppColors.surface,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          const Text(
            "Price Details",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 6),
          
          const Divider(),

          const SizedBox(height: 6),

          _row("Standard (x$ticketCount)", "$ticketTotal VND"),

          if (comboPrice > 0)
            _row("Food Combo", "$comboPrice VND"),

          _row("Voucher", "-$voucher VND"),

          const Divider(),

          _row(
            "Actual Pay",
            "$total VND",
            highlight: true,
          )
        ],
      ),
    );
  }

  Widget _row(
    String label,
    String value, {
    bool highlight = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(label),

          Text(
            value,
            style: TextStyle(
              color: highlight ? Colors.red : null,
              fontWeight:
                  highlight ? FontWeight.w700 : null,
            ),
          ),
        ],
      ),
    );
  }
}