import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/formatters/money_formatter.dart';
import '../providers/voucher_provider.dart';

class VoucherBottomSheet extends ConsumerWidget {
  const VoucherBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vouchersAsync = ref.watch(vouchersProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      child: vouchersAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),

        error: (e, _) => Center(
          child: Text(e.toString()),
        ),

        data: (vouchers) {
          return ListView(
            shrinkWrap: true,
            children: vouchers.map((voucher) {
              return ListTile(
                title: Text(voucher.code),
                subtitle: Text(voucher.title),
                trailing: Text(
                  "-${MoneyFormatter.vnd(voucher.discount)}",
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  ref.read(selectedVoucherProvider.notifier).state = voucher;
                  Navigator.pop(context);
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}