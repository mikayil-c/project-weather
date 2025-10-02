import 'package:project_weather/app/constants/hive_constants.dart';
import 'package:project_weather/models/model/daily_forecast_packet.dart';
import 'package:project_weather/models/model/hourly_forecast_packet.dart';
import 'package:project_weather/models/model/location_model.dart';
import 'package:project_weather/models/model/weather_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CacheService {
  Box get savedLocationsBox => Hive.box(HiveConstants.savedLocationsBoxName);
  Box get weatherBox => Hive.box<WeatherModel>(HiveConstants.weatherBoxName);
  Box get hourlyForecastBox =>
      Hive.box<HourlyForecastPacket>(HiveConstants.hourlyForecastBoxName);
  Box get dailyForecastBox =>
      Hive.box<DailyForecastPacket>(HiveConstants.dailyForecastBoxName);

  // --------------GET--------------
  Future<List<LocationModel>?> getSavedLocations() async {
    try {
      final list = savedLocationsBox.get(HiveConstants.savedLocationsKey);
      return (list as List).cast<LocationModel>();
    } catch (e) {
      return null;
    }
  }

  Future<WeatherModel?> getWeather() async {
    try {
      final cached = weatherBox.get(HiveConstants.weatherKey) as WeatherModel?;
      return cached;
    } catch (e) {
      return null;
    }
  }

  Future<DailyForecastPacket?> getDailyForecast() async {
    try {
      final cached = dailyForecastBox.get(HiveConstants.savedLocationsKey);
      return cached;
    } catch (e) {
      return null;
    }
  }

  Future<HourlyForecastPacket?> getHourlyForecast() async {
    try {
      final cached = hourlyForecastBox.get(HiveConstants.hourlyForecastKey);
      return cached;
    } catch (e) {
      return null;
    }
  }

  // --------------SAVE--------------
  Future<void> saveSavedLocations(List<LocationModel> list) async {
    try {
      await savedLocationsBox.put(HiveConstants.savedLocationsKey, list);
    } catch (e) {
      throw Exception('Failed to save locations');
    }
  }

  Future<void> saveWeather(WeatherModel weather) async {
    try {
      await weatherBox.put(HiveConstants.weatherKey, weather);
    } catch (e) {
      throw Exception('Failed to save weather');
    }
  }

  Future<void> saveDailyForecast(DailyForecastPacket? daily) async {
    try {
      if (daily == null) return;
      await dailyForecastBox.put(HiveConstants.dailyForecastKey, daily);
    } catch (e) {
      throw Exception('Failed to save daily forecast');
    }
  }

  Future<void> saveHourlyForecast(HourlyForecastPacket? hourly) async {
    try {
      if (hourly == null) return;
      await hourlyForecastBox.put(HiveConstants.hourlyForecastKey, hourly);
    } catch (e) {
      throw Exception('Failed to save hourly forecast');
    }
  }

  // --------------CLEAR--------------
  Future<void> clearSavedLocations() async {
    await savedLocationsBox.clear();
  }

  Future<void> clearWeather() async {
    await weatherBox.clear();
  }

  Future<void> clearDailyForecast() async {
    await dailyForecastBox.clear();
  }

  Future<void> clearHourlyForecast() async {
    await hourlyForecastBox.clear();
  }

  Future<void> clearAll() async {
    await clearWeather();
    await clearDailyForecast();
    await clearHourlyForecast();
  }
}
