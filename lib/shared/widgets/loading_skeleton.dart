import 'package:flutter/material.dart';

class LoadingSkeleton extends StatelessWidget {
  final double height;
  final double width;

  const LoadingSkeleton({
    super.key,
    this.height = 150,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, width: width);
  }
}
