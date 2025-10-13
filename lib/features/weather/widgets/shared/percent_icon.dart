import 'package:flutter/material.dart';

class PercentIcon extends StatelessWidget {
  final IconData icon;
  final double percentage;
  final Color filledColor;
  final Color emptyColor;
  final double size;

  const PercentIcon({
    super.key,
    required this.icon,
    required this.percentage,
    this.filledColor = Colors.white,
    this.emptyColor = const Color.fromARGB(50, 255, 255, 255),
    this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(icon, size: size, color: emptyColor,),
        ClipRect(
          clipper: _IconClipper(percentage),
          child: Icon(icon, size: size, color: filledColor),
        ),
      ],
    );
  }
}

class _IconClipper extends CustomClipper<Rect> {
  final double percentage;
  _IconClipper(this.percentage);

  @override
  Rect getClip(Size size) {
    final filledHeight = size.height * (1 - percentage);
    return Rect.fromLTWH(0, filledHeight, size.width, size.height * percentage);
  }

  @override
  bool shouldReclip(_IconClipper oldClipper) =>
      oldClipper.percentage != percentage;
}
