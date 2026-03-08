import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/combo_provider.dart';

class ComboSlider extends ConsumerWidget {
  const ComboSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combosAsync = ref.watch(combosProvider);
    final selected = ref.watch(selectedCombosProvider);

    return SizedBox(
      height: 465,
      child: combosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (e, _) => Text(e.toString()),

        data: (combos) {
          return PageView.builder(
            controller: PageController(viewportFraction: 0.85),
            itemCount: combos.length,
            itemBuilder: (context, index) {
              final combo = combos[index];
              final qty = selected[combo.id] ?? 0;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),

                child: Container(
                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.05),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// IMAGE
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          combo.image,
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
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
                            '${combo.price} VND',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Text(
                        combo.description,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),

                      const SizedBox(height: 20),

                      /// STEPPER
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _qtyButton(
                            icon: Icons.remove,
                            onTap: () {
                              ref
                                  .read(selectedCombosProvider.notifier)
                                  .remove(combo.id);
                            },
                          ),

                          const SizedBox(width: 20),

                          Text(
                            qty.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(width: 20),

                          _qtyButton(
                            icon: Icons.add,
                            onTap: () {
                              ref
                                  .read(selectedCombosProvider.notifier)
                                  .add(combo.id);
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
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
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
                                ),
                                onPressed: () {
                                  ref
                                      .read(selectedCombosProvider.notifier)
                                      .add(combo.id);
                                },
                                child: const Text(
                                  "Add",
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
                ),
              );
            },
          );
        },
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
