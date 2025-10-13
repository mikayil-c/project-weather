import 'package:flutter/material.dart';
import 'package:project_weather/l10n/app_localizations.dart';

enum Distance {
  heavyFog,
  fog,
  veryLowVisibility,
  lowVisibility,
  limited,
  medium,
  clear,
  veryClear,
}

extension DistanceExtension on Distance {
  String getTitle(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    switch (this) {
      case Distance.heavyFog:
        return localizations.heavyFog;
      case Distance.fog:
        return localizations.fog;
      case Distance.veryLowVisibility:
        return localizations.veryLowVisibility;
      case Distance.lowVisibility:
        return localizations.lowVisibility;
      case Distance.limited:
        return localizations.limited;
      case Distance.medium:
        return localizations.medium;
      case Distance.clear:
        return localizations.clear;
      case Distance.veryClear:
        return localizations.veryClear;
    }
  }

  String getInfo(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    switch (this) {
      case Distance.heavyFog:
        return localizations.heavyFogInfo;
      case Distance.fog:
        return localizations.fogInfo;
      case Distance.veryLowVisibility:
        return localizations.veryLowVisibilityInfo;
      case Distance.lowVisibility:
        return localizations.lowVisibilityInfo;
      case Distance.limited:
        return localizations.limitedInfo;
      case Distance.medium:
        return localizations.mediumVisibilityInfo;
      case Distance.clear:
        return localizations.clearInfo;
      case Distance.veryClear:
        return localizations.veryClearInfo;
    }
  }
}
