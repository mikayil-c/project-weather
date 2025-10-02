import 'dart:ui' as ui;
import 'dart:ui';

import 'package:project_weather/models/model/unit_model.dart';

class SettingsHelper {
  static const imperialCountries = [
    'US',
    'LR',
    'MM',
    'BS',
    'BZ',
    'KY',
    'PR',
    'GU',
    'VI',
  ];

  static Locale getSystemLocale() {
    final systemLocale = ui.PlatformDispatcher.instance.locale;
    return systemLocale;
  }

  static UnitModel getSystemUnit() {
    final systemLocale = getSystemLocale();
    final countryCode = systemLocale.countryCode?.toUpperCase() ?? '';

    return !imperialCountries.contains(countryCode)
        ? UnitModel.metric
        : UnitModel.imperial;
  }

  static double convertTemperature(double temp, UnitModel from, UnitModel to) {
    if (from == to) return temp;
    if (to == UnitModel.metric) {
      return temp - 273.15;
    }
    if (to == UnitModel.imperial) {
      return ((temp - 273.15) * 9 / 5 + 32);
    }
    return temp;
  }

  static String formatTemperature(
    double temp,
    UnitModel? to, {
    bool isThereSymbol = false,
  }) {
    final unit = to ?? getSystemUnit();
    if (isThereSymbol) {
      final symbol = unit.formatTemperature;
      return '${temp.toStringAsFixed(0)}$symbol';
    }
    return '${temp.toStringAsFixed(0)}°';
  }

  static double convertSpeed(double speed, UnitModel from, UnitModel to) {
    if (from == to) return speed;
    if (to == UnitModel.metric) {
      return speed * 3.6;
    }
    if (to == UnitModel.imperial) {
      return speed * 2.237;
    }
    return speed;
  }

  static String formatSpeed(double speed, UnitModel? to) {
    final unit = to ?? getSystemUnit();
    final symbol = unit.formatSpeed;
    return '${speed.toStringAsFixed(1)} $symbol';
  }

  static double convertDistance(double distance, UnitModel from, UnitModel to) {
    if (from == to) return distance;
    if (to == UnitModel.metric) {
      return distance / 1000;
    }
    if (to == UnitModel.imperial) {
      return distance / 1609000;
    }
    return distance;
  }

  static String formatDistance(double distance, UnitModel? to) {
    final unit = to ?? getSystemUnit();
    final symbol = unit.formatDistance;
    return '${distance.toStringAsFixed(1)} $symbol';
  }
}
