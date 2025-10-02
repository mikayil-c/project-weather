import 'dart:ui';
import 'package:flutter/material.dart';

class SmallInfoPopup extends StatelessWidget {
  final String text;
  final Icon icon;
  final double width;

  const SmallInfoPopup({
    super.key,
    required this.text,
    this.icon = const Icon(
      Icons.info_outline,
      size: 20,
      color: Colors.lightBlueAccent,
    ),
    this.width = 200,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showSmallPopup(context),
      child: SizedBox(child: icon),
    );
  }

  void _showSmallPopup(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final screenSize = MediaQuery.of(context).size;

    double finalLeft = position.dx;
    if (finalLeft + width > screenSize.width) {
      finalLeft = screenSize.width - width - 16.0;
    }
    if (finalLeft < 16.0) {
      finalLeft = 16.0;
    }

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(color: Colors.transparent),
              ),
            ),

            Positioned(
              left: finalLeft,
              top: position.dy + size.height,
              child: FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                    CurvedAnimation(parent: animation, curve: Curves.easeOut),
                  ),
                  child: InfoPopup(text: text, width: width),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class InfoPopup extends StatelessWidget {
  const InfoPopup({super.key, required this.text, required this.width});

  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        width: width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.3),
                  width: 0.5,
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withValues(alpha: 0.9),
                  height: 1.4,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
