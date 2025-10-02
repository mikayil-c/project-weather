import 'package:flutter/material.dart';
import 'package:project_weather/l10n/app_localizations.dart';

enum Pressure { veryLow, low, medium, high, veryHigh }

extension PressureExtension on Pressure {
  String getTitle(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    switch (this) {
      case Pressure.veryLow:
        return localizations.veryLowPressure;
      case Pressure.low:
        return localizations.lowPressure;
      case Pressure.medium:
        return localizations.mediumPressure;
      case Pressure.high:
        return localizations.highPressure;
      case Pressure.veryHigh:
        return localizations.veryHighPressure;
    }
  }

  String getInfo(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    switch (this) {
      case Pressure.veryLow:
        return localizations.veryLowPressureInfo;
      case Pressure.low:
        return localizations.lowPressureInfo;
      case Pressure.medium:
        return localizations.mediumPressureInfo;
      case Pressure.high:
        return localizations.highPressureInfo;
      case Pressure.veryHigh:
        return localizations.veryHighPressureInfo;
    }
  }
}
