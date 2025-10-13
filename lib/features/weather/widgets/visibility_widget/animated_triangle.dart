import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_weather/features/weather/widgets/visibility_widget/triangle_painter.dart';

class AnimatedTriangle extends StatefulWidget {
  final double targetFillPercentage;
  final Duration animationDuration;
  final Color fillColor;
  final Color emptyColor;
  final Curve animationCurve;
  final String text;

  const AnimatedTriangle({
    super.key,
    required this.targetFillPercentage,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.fillColor = Colors.blue,
    this.emptyColor = Colors.grey,
    this.animationCurve = Curves.easeInOut,
    this.text = '',
  });

  @override
  State<AnimatedTriangle> createState() => _AnimatedTriangleState();
}

class _AnimatedTriangleState extends State<AnimatedTriangle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _previousValue = 0.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _setupAnimation(_previousValue, widget.targetFillPercentage);

    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedTriangle oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.targetFillPercentage != widget.targetFillPercentage) {
      _setupAnimation(_animation.value, widget.targetFillPercentage);
      _controller
        ..reset()
        ..forward();
    }
  }

  void _setupAnimation(double from, double to) {
    _animation = Tween<double>(begin: from, end: to.clamp(0.0, 1.0)).animate(
      CurvedAnimation(parent: _controller, curve: widget.animationCurve),
    );
    _previousValue = to;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            CustomPaint(
              size: const Size(120, 120),
              painter: TrianglePainter(
                fillPercentage: _animation.value,
                fillColor: widget.fillColor,
                emptyColor: widget.emptyColor,
              ),
            ),
            Positioned(
              top: -15,
              child: Transform.rotate(
                angle: (pi / 2),
                child: Icon(Icons.tonality_sharp, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
