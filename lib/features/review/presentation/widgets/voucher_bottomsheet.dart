import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters/money_formatter.dart';
import '../providers/voucher_provider.dart';

class VoucherBottomSheet extends ConsumerWidget {
  const VoucherBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vouchers = ref.watch(vouchersProvider).value ?? [];
    final selected = ref.watch(selectedVoucherProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      height: 420,

      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "Available Vouchers",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),

          const SizedBox(height: 16),

          Expanded(
            child: ListView.builder(
              itemCount: vouchers.length,

              itemBuilder: (context, index) {
                final voucher = vouchers[index];
                final isSelected = selected?.id == voucher.id;

                return InkWell(
                  onTap: () {
                    final notifier = ref.read(selectedVoucherProvider.notifier);

                    if (selected?.id == voucher.id) {
                      notifier.state = null;
                    } else {
                      notifier.state = voucher;
                    }
                  },

                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),

                    child: Row(
                      children: [
                        /// CHECK ICON
                        Icon(
                          isSelected
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: isSelected ? AppColors.primary : Colors.grey,
                        ),

                        const SizedBox(width: 12),

                        /// INFO
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                voucher.code,
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                voucher.description,
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// PRICE
                        Text(
                          "-${MoneyFormatter.vnd(voucher.discountValue)}",
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
