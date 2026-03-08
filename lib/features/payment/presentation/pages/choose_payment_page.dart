import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../checkout/providers/booking_draft_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

import '../providers/payment_providers.dart';
import '../widgets/payment_item.dart';

class ChoosePaymentPage extends ConsumerWidget {
  const ChoosePaymentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final methodsAsync = ref.watch(paymentMethodsProvider);
    final selected = ref.watch(selectedPaymentProvider);

    final draft = ref.watch(bookingDraftProvider);
    final price = (draft?.seats.length ?? 0) * 12;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
              onPressed: () {},
            ),
            title: const Text(
              "Choose Payment Method",
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 26,
              ),
            ),
          ),
        ),
      ),

      body: methodsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (e, _) => Center(child: Text(e.toString())),

        data: (methods) {
          return Padding(
            padding: const EdgeInsets.all(AppSpacing.pagePadding),

            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: methods.length,

                    separatorBuilder: (_, __) => const SizedBox(height: 12),

                    itemBuilder: (context, index) {
                      final method = methods[index];

                      return PaymentItem(
                        method: method,

                        selected: selected?.id == method.id,

                        onTap: () {
                          ref.read(selectedPaymentProvider.notifier).state =
                              method;

                          final draft = ref.read(bookingDraftProvider);

                          if (draft != null) {
                            ref.read(bookingDraftProvider.notifier).state =
                                draft.copyWith(paymentMethod: method.id);
                          }
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  height: 50,
                  width: double.infinity,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color.fromARGB(255, 255, 229, 229),
                  ),

                  child: const Center(
                    child: Text(
                      "+  Add New Payment",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    onPressed: selected == null
                        ? null
                        : () {
                            //context.go('/ticket-success');
                          },
                    child: Text(
                      "Confirm Payment - \$${price.toStringAsFixed(2)}",
                      style: TextStyle(color: AppColors.onPrimary),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
