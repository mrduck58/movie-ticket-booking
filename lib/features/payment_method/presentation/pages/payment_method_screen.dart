import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/payment_method.dart';
import '../providers/payment_method_providers.dart';

class ChoosePaymentMethodScreen extends ConsumerWidget {
  const ChoosePaymentMethodScreen({super.key});

  static const red = Color(0xFFE53935);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(paymentMethodControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          "Payments Method",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                "05:42",
                style: TextStyle(
                  color: red,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
        ],
      ),

      // ================= BODY =================
      body: vm.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Error: $e',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        data: (data) {
          final methods = data.methods;
          final selectedId = data.selectedId;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(18),
                  itemCount: methods.length,
                  itemBuilder: (context, index) {
                    final item = methods[index];
                    final isSelected = selectedId == item.id;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: GestureDetector(
                        onTap: () {
                          ref
                              .read(paymentMethodControllerProvider.notifier)
                              .select(item.id);
                        },
                        child: Container(
                          height: 64,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected ? red : Colors.transparent,
                              width: 1.6,
                            ),
                          ),
                          child: Row(
                            children: [
                              _PaymentLogo(type: item.type),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                const Icon(Icons.check, color: red, size: 20),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // ========== ADD NEW PAYMENT ==========
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: GestureDetector(
                  onTap: () {
                    ref
                        .read(paymentMethodControllerProvider.notifier)
                        .addNewMockCard();
                  },
                  child: Container(
                    height: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE8E6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: red),
                        SizedBox(width: 8),
                        Text(
                          "Add New Payment",
                          style: TextStyle(
                            color: red,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ========== CONFIRM BUTTON ==========
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      // Bạn có thể lấy selectedId để xử lý confirm
                      final selected = ref
                          .read(paymentMethodControllerProvider)
                          .value
                          ?.selectedId;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            selected == null
                                ? 'No payment method selected'
                                : 'Selected: $selected',
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Confirm Payment - \$10.00",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ================= LOGO =================
class _PaymentLogo extends StatelessWidget {
  final PaymentType type;
  const _PaymentLogo({required this.type});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 44,
      child: Image.asset(
        _assetPath(type),
        fit: BoxFit.contain,
      ),
    );
  }

  String _assetPath(PaymentType type) {
    switch (type) {
      case PaymentType.paypal:
        return "assets/payment/paypal.png";
      case PaymentType.googlePay:
        return "assets/payment/google_pay.png";
      case PaymentType.applePay:
        return "assets/payment/apple_pay.png";
      case PaymentType.mastercard:
        return "assets/payment/mastercard.png";
      case PaymentType.visa:
        return "assets/payment/visa.png";
    }
  }
}