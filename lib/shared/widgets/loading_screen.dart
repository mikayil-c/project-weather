import 'package:flutter/material.dart';
import 'package:project_weather/app/constants/text_constants.dart';
import 'package:project_weather/shared/widgets/my_indicator.dart';

class LoadingScreen extends StatelessWidget {
  final String? message;
  final Color color;
  final double size;

  const LoadingScreen({
    super.key,
    this.message,
    this.color = Colors.transparent,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: size, height: size, child: const MyIndicator()),
            if (message != null) ...[
              const SizedBox(height: 16),
              Text(
                message!,
                style: TextConstants.loadingScreenText,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
