import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/core/utils/formatters/money_formatter.dart';
import 'package:movie_ticket_booking/features/food_combo/presentation/providers/cart_combo_provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constant.dart';
import '../../../../domain/entities/combo.dart';
import '../providers/combo_provider.dart';

class ComboDetailSheet extends ConsumerWidget {
  final Combo combo;

  const ComboDetailSheet({super.key, required this.combo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedCombosProvider);
    final qty = selected[combo.id] ?? 0;

    return Container(
      height: 730,
      padding: const EdgeInsets.all(16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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

          /// IMAGE
          SizedBox(
            width: double.infinity,
            height: 450,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(combo.image, fit: BoxFit.cover),
            ),
          ),

          const SizedBox(height: 12),

          /// TITLE
          Row(
            children: [
              Text(
                '${combo.name} -',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(width: 6),

              Text(
                MoneyFormatter.vnd(combo.price),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// DESCRIPTION
          Text(
            combo.description,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 20),

          /// STEPPER
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _qtyButton(
                icon: Icons.remove,
                onTap: () {
                  ref.read(selectedCombosProvider.notifier).remove(combo.id);
                },
              ),

              const SizedBox(width: 50),

              Text(
                qty.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(width: 50),

              _qtyButton(
                icon: Icons.add,
                onTap: () {
                  ref.read(selectedCombosProvider.notifier).add(combo.id);
                },
              ),
            ],
          ),

          const Spacer(),

          /// BUTTONS
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 240, 240),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      shadowColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      shadowColor: Colors.white,
                    ),
                    onPressed: () {
                      ref.read(cartComboProvider.notifier).addCombo(combo.id);

                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Add to Basket",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _qtyButton({required IconData icon, required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: 45,
      height: 45,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary),
      ),

      child: Icon(icon, color: AppColors.primary),
    ),
  );
}
