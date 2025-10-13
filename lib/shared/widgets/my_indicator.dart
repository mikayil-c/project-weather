import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyIndicator extends StatelessWidget {
  final Color color;
  const MyIndicator({super.key, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.inkDrop(color: color, size: 36);
  }
}
