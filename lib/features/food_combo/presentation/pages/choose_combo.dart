import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_ticket_booking/features/checkout/providers/booking_draft_provider.dart';
import 'package:movie_ticket_booking/features/food_combo/presentation/widgets/basket_bar.dart';
import 'package:movie_ticket_booking/features/food_combo/presentation/widgets/combo_card.dart';
import 'package:movie_ticket_booking/features/food_combo/presentation/widgets/most_popular_section.dart';
import 'package:movie_ticket_booking/features/food_combo/presentation/widgets/new_beverage_section.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters/money_formatter.dart';

import '../../../../domain/entities/combo.dart';
import '../providers/combo_provider.dart';

class FoodOrderPage extends ConsumerWidget {
  const FoodOrderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combosAsync = ref.watch(combosProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          "Choose Food Combo(s)",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: combosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (combos) {
          return Stack(
            children: [
              ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  MostPopularSection(combos: combos),
                  
                  const SizedBox(height: 20),

                  NewBeverageSection(combos: combos),

                  const SizedBox(height: 100), // tránh bị basket che
                ],
              ),

              /// Basket Bar
              const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: BasketBar(),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            minimumSize: const Size.fromHeight(64),
          ),
          onPressed: () {
            ref.read(bookingDraftProvider.notifier);
            context.push('/review');
          },
          child: const Text(
            "Continue",
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
