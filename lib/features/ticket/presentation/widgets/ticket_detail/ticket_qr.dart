import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:movie_ticket_booking/core/theme/app_colors.dart';

class TicketQR extends StatefulWidget {
  final List<String> qrDatas;

  const TicketQR({super.key, required this.qrDatas});

  @override
  State<TicketQR> createState() => _TicketQRState();
}

class _TicketQRState extends State<TicketQR> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.qrDatas.isEmpty) {
      return const Center(child: Text("No QR codes available"));
    }

    return Column(
      children: [
        SizedBox(
          height: 250,
          child: PageView.builder(
            itemCount: widget.qrDatas.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final qrData = widget.qrDatas[index];
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: QrImageView(
                      data: qrData,
                      version: QrVersions.auto,
                      size: 180.0,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    qrData,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 10,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        if (widget.qrDatas.length > 1) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.qrDatas.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index
                      ? AppColors.primary
                      : Colors.grey.withOpacity(0.3),
                ),
              ),
            ),
          ),
        ],
        const SizedBox(height: 16),
        const Text(
          "Scan this QR code at the entrance",
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}