import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/core/utils/formatters/money_formatter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constant.dart';

import '../../../food_combo/presentation/providers/combo_provider.dart';
import '../../../food_combo/presentation/providers/cart_combo_provider.dart';

class ComboSection extends ConsumerWidget {
  final bool readOnly;

  const ComboSection({super.key, this.readOnly = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combosAsync = ref.watch(combosProvider);
    final cart = ref.watch(cartComboProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          const Text(
            "Food Combo Details",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),

          const Divider(),
          const SizedBox(height: 8),
          combosAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            ),

            error: (e, _) => Text(e.toString()),

            data: (combos) {
              if (cart.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    "No combo selected",
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }

              return Column(
                children: cart.map((cartItem) {

                  final combo = combos.firstWhere(
                    (c) => c.id == cartItem.comboId,
                  );

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),

                    padding: const EdgeInsets.all(12),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),

                    child: Row(
                      children: [

                        /// IMAGE
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            combo.image,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(width: 12),

                        /// INFO
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                combo.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                MoneyFormatter.vnd(combo.price * cartItem.quantity),
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// QUANTITY
                        Text(
                          "x${cartItem.quantity}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  );

                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}