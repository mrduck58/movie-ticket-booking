import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/core/theme/app_colors.dart';
import '../../../../domain/entities/payment_method.dart';

class PaymentItem extends StatelessWidget {
  final PaymentMethod method;
  final bool selected;
  final VoidCallback onTap;

  const PaymentItem({
    super.key,
    required this.method,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),

          border: Border.all(
            color: selected ? AppColors.primary : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
        ),

        child: Row(
          children: [
            Image.asset(method.icon, width: 36),

            const SizedBox(width: 16),

            Expanded(
              child: Text(
                method.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            if (selected) const Icon(Icons.check, color: Colors.red),
          ],
        ),
      ),
    );
  }
}
