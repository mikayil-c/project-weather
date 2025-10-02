import 'package:flutter/material.dart';
import 'package:project_weather/l10n/app_localizations.dart';

enum Humidity { low, medium, high, veryHigh }

extension HumidityExtension on Humidity {
  String getTitle(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    switch (this) {
      case Humidity.low:
        return localizations.lowHum;
      case Humidity.medium:
        return localizations.mediumHum;
      case Humidity.high:
        return localizations.highHum;
      case Humidity.veryHigh:
        return localizations.veryHighHum;
    }
  }

  String getInfo(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    switch (this) {
      case Humidity.low:
        return localizations.lowHumidityInfo;
      case Humidity.medium:
        return localizations.mediumHumidityInfo;
      case Humidity.high:
        return localizations.highHumidityInfo;
      case Humidity.veryHigh:
        return localizations.veryHighHumidityInfo;
    }
  }
}
