import 'package:flutter/material.dart';

class ItemContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double borderRadius;
  final double? width;
  final double? height;

  const ItemContainer({
    super.key,
    required this.child,
    this.color = const Color.fromARGB(30, 0, 0, 0),
    this.borderRadius = 12,
    this.margin = const EdgeInsets.all(6),
    this.padding = const EdgeInsets.all(8),
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color,
      ),

      child: Padding(padding: padding, child: child),
    );
  }
}
