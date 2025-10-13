import 'package:flutter/material.dart';
import 'package:project_weather/app/constants/text_constants.dart';

class ErrorScreen extends StatelessWidget {
  final String? title;
  final String message;
  final VoidCallback? onRetry;
  final String? retryButtonText;
  final IconData? errorIcon;
  final List<Widget>? additionalActions;
  final Color? backgroundColor;

  const ErrorScreen({
    super.key,
    this.title,
    required this.message,
    this.onRetry,
    this.retryButtonText,
    this.errorIcon,
    this.additionalActions,
    this.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(errorIcon ?? Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            if (title != null) ...[
              Text(
                title!,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextConstants.errorScreenTitle,
            ),
            const SizedBox(height: 24),
            if (onRetry != null)
              OutlinedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(
                  retryButtonText ?? 'Try Again',
                  style: TextConstants.errorScreenButtonText,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade100,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            if (additionalActions != null) ...[
              const SizedBox(height: 8),
              ...additionalActions!,
            ],
          ],
        ),
      ),
    );
  }
}
