import 'package:flutter/material.dart';
import '../app_button.dart';
import '../../error/app_error.dart';
import '../../error/error_ui_mapper.dart';

class AppErrorView extends StatelessWidget {
  const AppErrorView({
    super.key,
    required this.error,
    this.onRetry,
  });

  final AppError error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final showRetry = ErrorUiMapper.shouldShowRetry(error) && onRetry != null;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(error.message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            if (showRetry) AppButton(label: 'Thử lại', onPressed: onRetry),
          ],
        ),
      ),
    );
  }
}