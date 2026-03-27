import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters/money_formatter.dart';

class TransactionDetailsSection extends StatelessWidget {
  final int totalPrice;
  final String bookingId;
  final String paymentMethod;

  const TransactionDetailsSection({
    super.key,
    required this.totalPrice,
    required this.bookingId,
    this.paymentMethod = 'PayOS',
  });

  @override
  Widget build(BuildContext context) {
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
            "Transaction Details",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const Divider(height: 24),

          _row("Amount", MoneyFormatter.vnd(totalPrice)),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Status",
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Paid",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          _row("Payment Method", paymentMethod),
          const SizedBox(height: 12),

          _copyRow(context, "Booking ID", bookingId),
        ],
      ),
    );
  }

  Widget _row(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            )),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _copyRow(BuildContext context, String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            )),
        Row(
          children: [
            Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(width: 6),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Copied to clipboard'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              child: const Icon(
                Icons.copy_outlined,
                size: 16,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}