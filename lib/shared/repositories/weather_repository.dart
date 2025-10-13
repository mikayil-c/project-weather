import 'package:project_weather/app/constants/duration_constants.dart';
import 'package:project_weather/models/model/daily_forecast_packet.dart';
import 'package:project_weather/models/model/hourly_forecast_packet.dart';
import 'package:project_weather/models/model/location_model.dart';
import 'package:project_weather/models/model/weather_model.dart';
import 'package:project_weather/shared/services/cache_service.dart';
import 'package:project_weather/shared/services/weather_service.dart';

class WeatherRepository {
  final CacheService _cacheService;
  final WeatherService _weatherService;

  const WeatherRepository(this._cacheService, this._weatherService);

  bool _isWeatherFresh(int dt) {
    final fetchedAt = DateTime.fromMillisecondsSinceEpoch(
      dt * 1000,
      isUtc: true,
    );
    final nowUtc = DateTime.now().toUtc();
    final diff = nowUtc.difference(fetchedAt);
    return diff < DurationConstants.weatherTtl;
  }

  bool _isHourlyFresh(int dt) {
    final fetchedAt = DateTime.fromMillisecondsSinceEpoch(
      dt * 1000,
      isUtc: true,
    );
    final nowUtc = DateTime.now().toUtc();
    final diff = nowUtc.difference(fetchedAt);
    return diff < DurationConstants.hourlyTtl;
  }

  bool _isDailyFresh(int dt) {
    final fetchedAt = DateTime.fromMillisecondsSinceEpoch(
      dt * 1000,
      isUtc: true,
    );
    final nowUtc = DateTime.now().toUtc();
    final diff = nowUtc.difference(fetchedAt);
    return diff < DurationConstants.dailyTtl;
  }

  Future<WeatherModel> getWeather(
    LocationModel location, {
    String lang = 'en',
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh) {
      final cached = await _cacheService.getWeather();
      if (cached != null && _isWeatherFresh(cached.dt)) {
        return cached;
      }
    }

    final fetched = await _weatherService.fetchWeather(
      location.lat,
      location.lon,
      lang,
    );

    await _cacheService.saveWeather(fetched);

    return fetched;
  }

  Future<HourlyForecastPacket> getHourlyForecast(
    LocationModel location, {
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh) {
      final cached = await _cacheService.getHourlyForecast();
      if (cached != null && _isHourlyFresh(cached.fetchedAt)) {
        return cached;
      }
    }

    final fetched = await _weatherService.fetchHourlyForecast(
      location.lat,
      location.lon,
    );

    await _cacheService.saveHourlyForecast(fetched);

    return fetched;
  }

  Future<DailyForecastPacket> getDailyForecast(
    LocationModel location, {
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh) {
      final cached = await _cacheService.getDailyForecast();
      if (cached != null && _isDailyFresh(cached.fetchedAt)) {
        return cached;
      }
    }

    final fetched = await _weatherService.fetchDailyForecast(
      location.lat,
      location.lon,
    );

    await _cacheService.saveDailyForecast(fetched);

    return fetched;
  }
}
