import 'package:project_weather/shared/repositories/weather_repository.dart';
import 'package:project_weather/shared/services/cache_service.dart';
import 'package:project_weather/shared/services/location_service.dart';
import 'package:project_weather/shared/services/network_service.dart';
import 'package:project_weather/shared/services/settings_service.dart';
import 'package:project_weather/shared/services/weather_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final networkServiceProvider = Provider<NetworkService>(
  (ref) => NetworkService(),
);

final weatherServiceProvider = Provider<WeatherService>(
  (ref) => WeatherService(),
);

final locationServiceProvider = Provider<LocationService>(
  (ref) => LocationService(),
);

final cacheServiceProvider = Provider<CacheService>((ref) => CacheService());

final settingsServiceProvider = Provider<SettingsService>(
  (ref) => SettingsService(),
);

final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  final cacheService = ref.read(cacheServiceProvider);
  final weatherService = ref.read(weatherServiceProvider);
  return WeatherRepository(cacheService, weatherService);
});
