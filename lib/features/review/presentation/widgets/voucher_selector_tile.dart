import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters/money_formatter.dart';
import '../providers/voucher_provider.dart';
import 'voucher_bottomsheet.dart';

class VoucherSelectorTile extends ConsumerWidget {
  const VoucherSelectorTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedVoucher = ref.watch(selectedVoucherProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),

      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),

      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            builder: (_) => const VoucherBottomSheet(),
          );
        },

        child: Row(
          children: [
            const Icon(Icons.local_offer, color: AppColors.primary),

            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Promo & Vouchers",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    selectedVoucher == null
                        ? "Select voucher"
                        : selectedVoucher.type == "PERCENTAGE"
                        ? "${selectedVoucher.code} (-${selectedVoucher.discountValue}%)"
                        : "${selectedVoucher.code} (-${MoneyFormatter.vnd(selectedVoucher.discountValue)})",
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
