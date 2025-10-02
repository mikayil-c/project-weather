import 'package:flutter/material.dart';
import 'package:project_weather/shared/helpers/date_helper.dart';
import 'package:project_weather/shared/helpers/settings_helper.dart';
import 'package:project_weather/l10n/app_localizations.dart';
import 'package:project_weather/models/app_models/distance.dart';
import 'package:project_weather/models/app_models/humidity.dart';
import 'package:project_weather/models/app_models/pressure.dart';
import 'package:project_weather/models/model/unit_model.dart';
import 'package:project_weather/models/app_models/wind.dart';

class FormatHelper {
  final String locale;
  final UnitModel unit;

  const FormatHelper(this.unit, this.locale);

  double convertTemperature(double temp) {
    return SettingsHelper.convertTemperature(temp, UnitModel.standart, unit);
  }

  String formatTemperature(double temp, {bool isThereSymbol = false}) {
    final converted = convertTemperature(temp);
    return SettingsHelper.formatTemperature(
      converted,
      unit,
      isThereSymbol: isThereSymbol,
    );
  }

  double convertSpeed(double speed) {
    return SettingsHelper.convertSpeed(speed, UnitModel.standart, unit);
  }

  String formatSpeed(double speed) {
    final converted = convertSpeed(speed);
    return SettingsHelper.formatSpeed(converted, unit);
  }

  double convertDistance(double distance) {
    return SettingsHelper.convertDistance(distance, UnitModel.standart, unit);
  }

  String formatDistance(double distance) {
    final converted = convertDistance(distance);
    return SettingsHelper.formatDistance(converted, unit);
  }

  String formatPressure(int pres) {
    return '$pres\nhPa';
  }

  String formatTimeForClock(int dt, int offset) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
      (dt + offset) * 1000,
      isUtc: true,
    );

    String formattedHour = dateTime.hour.toString().padLeft(2, '0');
    String formattedMinute = dateTime.minute.toString().padLeft(2, '0');

    return '$formattedHour:$formattedMinute';
  }

  String formatTimeForDay(BuildContext context, int dt) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
      dt * 1000,
      isUtc: false,
    );
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final targetDay = DateTime(dateTime.year, dateTime.month, dateTime.day);
    final difference = targetDay.difference(today).inDays;

    if (difference == 0) {
      return AppLocalizations.of(context)!.today;
    } else if (difference > 0 && difference <= 6) {
      return DateHelper.getDayName(dateTime, locale);
    } else {
      return DateHelper.getFormattedDate(dateTime, locale);
    }
  }

  Wind getWindCategory(double speed) {
    if (speed <= 5) return Wind.calm;
    if (speed <= 11) return Wind.lightBreeze;
    if (speed <= 19) return Wind.gentleBreeze;
    if (speed <= 28) return Wind.moderateBreeze;
    if (speed <= 38) return Wind.strongBreeze;
    if (speed <= 49) return Wind.gale;
    return Wind.storm;
  }

  Humidity getHumidityCategory(int hum) {
    if (hum <= 30) return Humidity.low;
    if (hum <= 60) return Humidity.medium;
    if (hum <= 80) return Humidity.high;
    return Humidity.veryHigh;
  }

  Distance getDistanceCategory(int dist) {
    if (dist <= 50) return Distance.heavyFog;
    if (dist <= 200) return Distance.fog;
    if (dist <= 500) return Distance.veryLowVisibility;
    if (dist <= 1000) return Distance.lowVisibility;
    if (dist <= 3000) return Distance.limited;
    if (dist <= 5000) return Distance.medium;
    if (dist <= 8000) return Distance.clear;
    return Distance.veryClear;
  }

  Pressure getPressureCategory(int pres) {
    if (pres <= 995) return Pressure.veryLow;
    if (pres <= 1009) return Pressure.low;
    if (pres <= 1020) return Pressure.medium;
    if (pres <= 1030) return Pressure.high;
    return Pressure.veryHigh;
  }
}
