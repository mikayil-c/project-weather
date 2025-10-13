import 'package:flutter/material.dart';
import 'package:project_weather/app/constants/hive_constants.dart';
import 'package:project_weather/l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'unit_model.g.dart';

@HiveType(typeId: HiveConstants.unitTypeId)
enum UnitModel {
  @HiveField(0)
  standart,
  @HiveField(1)
  metric,
  @HiveField(2)
  imperial,
}

extension UnitExtension on UnitModel {
  String getText(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    switch (this) {
      case UnitModel.standart:
        return localizations.standart;
      case UnitModel.metric:
        return localizations.metric;
      case UnitModel.imperial:
        return localizations.imperial;
    }
  }

  String get formatTemperature {
    switch (this) {
      case UnitModel.standart:
        return 'K';
      case UnitModel.metric:
        return '°C';
      case UnitModel.imperial:
        return '°F';
    }
  }

  String get formatSpeed {
    switch (this) {
      case UnitModel.standart:
        return 'm/s';
      case UnitModel.metric:
        return 'km/h';
      case UnitModel.imperial:
        return 'mph';
    }
  }

  String get formatDistance {
    switch (this) {
      case UnitModel.standart:
        return 'm';
      case UnitModel.metric:
        return 'km';
      case UnitModel.imperial:
        return 'mile';
    }
  }
}
