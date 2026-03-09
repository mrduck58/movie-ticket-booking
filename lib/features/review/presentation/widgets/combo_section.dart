import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constant.dart';
import '../providers/combo_provider.dart';
import 'combo_slider.dart';

class ComboSection extends ConsumerWidget {
  final bool readOnly;
  const ComboSection({super.key, this.readOnly = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combosAsync = ref.watch(combosProvider);
    final selected = ref.watch(selectedCombosProvider);

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Food Combo Details",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),

              if (!readOnly)
                InkWell(
                  onTap: () {
                    _openComboSelector(context, ref);
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    children: const [
                      Text(
                        "Add Combo",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
            ],
          ),

          const Divider(),

          combosAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            ),

            error: (e, _) => Text(e.toString()),

            data: (combos) {
              final selectedCombos = combos
                  .where((combo) => selected.containsKey(combo.id))
                  .toList();

              if (selectedCombos.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    "No combo selected",
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }

              return Column(
                children: selectedCombos.map((combo) {
                  final qty = selected[combo.id]!;

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
                        Image.asset(combo.image, width: 60),

                        const SizedBox(width: 12),

                        /// INFO
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                combo.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                "${combo.price} ${AppConstants.currencySymbol}",
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Text(
                          "x$qty",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(width: 6),

                        if (!readOnly)
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _openComboSelector(context, ref);
                            },
                          ),
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

void _openComboSelector(BuildContext context, WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,

    builder: (_) {
      return DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.6,
        maxChildSize: 0.95,
        expand: false,

        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: const ComboSlider(),
          );
        },
      );
    },
  );
}
