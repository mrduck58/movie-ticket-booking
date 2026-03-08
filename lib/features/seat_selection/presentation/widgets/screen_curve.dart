import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/core/theme/app_colors.dart';

class ScreenCurve extends StatelessWidget {
  const ScreenCurve({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 80,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            /// ánh sáng + màn hình
            CustomPaint(
              size: const Size(double.infinity, 80),
              painter: ScreenPainter(),
            ),

            /// text nằm trong vùng ánh sáng
            Positioned(
              top: 40,
              child: Text(
                "Cinema Screen Here",
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    /// ánh sáng màn hình
    final lightPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.primary.withOpacity(0.5),
          AppColors.primary.withOpacity(0.2),
          AppColors.primary.withOpacity(0.05),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final lightPath = Path();

    lightPath.moveTo(10, size.height * 0.5);
    lightPath.quadraticBezierTo(
      size.width / 2,
      0,
      size.width - 10,
      size.height * 0.5,
    );
    lightPath.lineTo(size.width - 10, size.height);
    lightPath.lineTo(10, size.height);
    lightPath.close();

    canvas.drawPath(lightPath, lightPaint);

    /// đường cong màn hình
    final screenPaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    final path = Path();

    path.moveTo(10, size.height * 0.5);
    path.quadraticBezierTo(
      size.width / 2,
      0,
      size.width - 10,
      size.height * 0.5,
    );

    canvas.drawPath(path, screenPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
