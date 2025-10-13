import 'package:flutter/material.dart';
import 'package:project_weather/l10n/app_localizations.dart';

enum Wind {
  calm,
  lightBreeze,
  gentleBreeze,
  moderateBreeze,
  strongBreeze,
  gale,
  storm,
}

extension WindExtension on Wind {
  String getTitle(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    switch (this) {
      case Wind.calm:
        return localizations.calmWind;
      case Wind.lightBreeze:
        return localizations.lightBreezeWind;
      case Wind.gentleBreeze:
        return localizations.gentleBreezeWind;
      case Wind.moderateBreeze:
        return localizations.moderateBreezeWind;
      case Wind.strongBreeze:
        return localizations.strongBreezeWind;
      case Wind.gale:
        return localizations.galeWind;
      case Wind.storm:
        return localizations.stormWind;
    }
  }

  String getInfo(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    switch (this) {
      case Wind.calm:
        return localizations.calmWindInfo;
      case Wind.lightBreeze:
        return localizations.lightBreezeWindInfo;
      case Wind.gentleBreeze:
        return localizations.gentleBreezeWindInfo;
      case Wind.moderateBreeze:
        return localizations.moderateBreezeWindInfo;
      case Wind.strongBreeze:
        return localizations.strongBreezeWindInfo;
      case Wind.gale:
        return localizations.galeWindInfo;
      case Wind.storm:
        return localizations.stormWindInfo;
    }
  }
}
