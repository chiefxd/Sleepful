// cloud_painter.dart
import 'package:flutter/material.dart';

class CloudPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFA594F9)//A594F9
      ..style = PaintingStyle.fill;

    // Calculate the number of circles based on the length of the rectangle
    const circleSpacing = 36.0;
    final numCircles = (size.width / circleSpacing).floor();

    // Draw a series of overlapping circles to create a cloud shape
    for (int i = 0; i < numCircles + 2; i++) {
      final x = i * circleSpacing - 5.0; // Move the first circle to the left
      final y = size.height - 10.0;
      const radius = 20.0;

      if (i % 2 != 0) { // Odd-numbered circles
        final rect = Rect.fromPoints(
          Offset(x - radius - radius / 2, y - radius / 2),
          Offset(x + radius + radius / 2, y + radius),
        );
        canvas.drawOval(rect, paint);
      } else { // Even-numbered circles
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}