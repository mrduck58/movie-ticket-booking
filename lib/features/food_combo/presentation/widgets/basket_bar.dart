import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/features/food_combo/presentation/widgets/cart_bottom_sheet.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters/money_formatter.dart';
import '../providers/cart_combo_provider.dart';
import '../providers/combo_provider.dart';

class BasketBar extends ConsumerWidget {
  const BasketBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartComboProvider);
    final combosAsync = ref.watch(combosProvider);

    if (cart.isEmpty) return const SizedBox();

    return combosAsync.when(
      loading: () => const SizedBox(),
      error: (_, __) => const SizedBox(),
      data: (combos) {
        int totalItems = 0;
        int totalPrice = 0;

        for (final item in cart) {
          final combo = combos.firstWhere((c) => c.id == item.comboId);

          totalItems += item.quantity;
          totalPrice += combo.price * item.quantity;
        }

        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              builder: (_) => const CartBottomSheet(),
            );
          },
          child: Container(
            height: 55,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.shopping_bag, color: AppColors.black),

                const SizedBox(width: 10),

                Text(
                  "$totalItems snacks or drinks",
                  style: const TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const Spacer(),

                Text(
                  MoneyFormatter.vnd(totalPrice),
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(width: 8),

                const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.black,
                  size: 16,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
