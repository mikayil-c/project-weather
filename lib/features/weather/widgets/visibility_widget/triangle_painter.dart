import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  final double fillPercentage;
  final Color fillColor;
  final Color emptyColor;

  TrianglePainter({
    required this.fillPercentage,
    required this.fillColor,
    required this.emptyColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [
        0.0,
        fillPercentage * 0.8,
        fillPercentage,
        (fillPercentage + 0.1).clamp(0.0, 1.0),
        1.0,
      ],
      colors: [
        fillColor,
        fillColor.withValues(alpha: 0.3),
        emptyColor.withValues(alpha: 0.7),
        emptyColor,
        emptyColor,
      ],
    );

    final paint = Paint()
      ..shader = gradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );

    canvas.drawPath(path, paint);

    final borderPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.fillPercentage != fillPercentage ||
        oldDelegate.fillColor != fillColor ||
        oldDelegate.emptyColor != emptyColor;
  }
}
