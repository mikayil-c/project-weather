import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_weather/app/constants/text_constants.dart';
import 'package:project_weather/features/weather/weather.dart';
import 'package:project_weather/l10n/app_localizations.dart';
import 'package:project_weather/shared/providers/location_provider.dart';
import 'package:project_weather/shared/providers/service_providers.dart';
import 'package:project_weather/features/location_selection/location_selection.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class Intro extends ConsumerWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // IMAGE
              Image.asset('assets/images/intro_image.png', width: 240),

              // INTRODUCTION TEXT
              Text(
                AppLocalizations.of(context)!.introDetail,
                textAlign: TextAlign.center,
                style: TextConstants.introText,
              ),

              const SizedBox(height: 24.0),

              // SELECT LOCATION BUTTON
              const SelectButton(),

              // DETECT LOCATION BUTTON
              DetectButton(onPressed: () => _detectLocation(context, ref)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _detectLocation(BuildContext context, WidgetRef ref) async {
    try {
      // a snackbar while detecting location
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(width: 16),
                Text(AppLocalizations.of(context)!.detectingLocation),
              ],
            ),
            duration: const Duration(seconds: 30),
          ),
        );
      }

      final locationService = ref.read(locationServiceProvider);

      // Get current position with timeout
      final pos = await locationService.getCurrentLocation().timeout(
        const Duration(seconds: 15),
      );

      // Get location details with timeout
      final loc = await locationService
          .getLocationFromCoord(pos.latitude, pos.longitude)
          .timeout(const Duration(seconds: 10));

      // Add location to saved locations
      await ref.read(locationNotifierProvider.notifier).addLocation(loc);

      // a snackbar when location detected
      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${AppLocalizations.of(context)!.locationDetected}: ${loc.name}',
            ),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Weather()),
        );
      }
    } on TimeoutException {
      // a snackbar when timed out
      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.locationDetectionTimedOut,
            ),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      // a snackbar when there is problem with permissions
      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        String errorMessage;
        if (e.toString().contains('permission')) {
          errorMessage = AppLocalizations.of(context)!.locationPermissionDenied;
        } else if (e.toString().contains('disabled')) {
          errorMessage = AppLocalizations.of(context)!.locationPermissionDenied;
        } else {
          errorMessage =
              '${AppLocalizations.of(context)!.failedToDetectLocation}: ${e.toString()}';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: AppLocalizations.of(context)!.tryAgain,
              onPressed: () => _detectLocation(context, ref),
            ),
          ),
        );
      }
    }
  }
}

class SelectButton extends StatelessWidget {
  const SelectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LocationSelection()),
        );
      },
      child: Text(
        AppLocalizations.of(context)!.introSelectButton,
        style: TextConstants.introButton,
      ),
    );
  }
}

class DetectButton extends StatelessWidget {
  final Future<void> Function() onPressed;

  const DetectButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await onPressed();
      },
      child: Text(
        AppLocalizations.of(context)!.introFindButton,
        style: TextConstants.introButton,
      ),
    );
  }
}
