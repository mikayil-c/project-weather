import 'package:flutter/material.dart';
import 'package:project_weather/app/constants/duration_constants.dart';
import 'package:project_weather/models/model/daily_forecast_packet.dart';
import 'package:project_weather/models/model/hourly_forecast_packet.dart';
import 'package:project_weather/models/model/location_model.dart';
import 'package:project_weather/models/state/weather_state.dart';
import 'package:project_weather/models/model/weather_model.dart';
import 'package:project_weather/shared/repositories/weather_repository.dart';
import 'package:project_weather/shared/providers/location_provider.dart';
import 'package:project_weather/shared/providers/service_providers.dart';
import 'package:project_weather/shared/providers/settings_provider.dart';
import 'package:project_weather/shared/services/network_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// before performing each operation, we ensure that we have recorded the state prior to the operation.

class WeatherViewModel extends AsyncNotifier<WeatherState> {
  WeatherRepository get _weatherRepository =>
      ref.read(weatherRepositoryProvider);

  NetworkService get _networkService => ref.read(networkServiceProvider);

  bool _isRefreshing = false;
  bool _listenersAttached = false;

  @override
  Future<WeatherState> build() async {
    debugPrint('Started <WeatherViewModel>build()');

    if (!_listenersAttached) {
      _attachListeners();
      _listenersAttached = true;
    }

    return _initializeAll();
  }


  Future<WeatherState> _initializeAll() async {
    try {
      debugPrint('Started _initializeAll()');
      final location = ref.read(locationNotifierProvider).value?.location;
      if (location == null) {
        debugPrint('During _initializeAll(): Location is null');
        return const WeatherState();
      }

      debugPrint(
        'During _initializeAll(): Initializing with location: ${location.toString()}',
      );
      return await _getAllData(location);
    } catch (e, stackTrace) {
      debugPrint(
        'During _initializeAll(): Could not initializate: $e, $stackTrace',
      );
      return WeatherState(errorMessage: e.toString());
    }
  }

  Future<void> refresh() async {
    if (_isRefreshing) {
      debugPrint('During refresh(): Refresh already in progress, skipping...');
      return;
    }
    _isRefreshing = true;
    final current = state.valueOrNull ?? const WeatherState();

    try {
      final isConnected = await _isConnected();
      if (!isConnected) {
        state = AsyncValue.data(current.copyWith(hasInternet: false));
        return;
      }

      final location = ref.read(
        locationNotifierProvider.select((state) => state.value?.location),
      );
      if (location == null) {
        debugPrint('During refresh(): Location is null');
        return;
      }

      debugPrint('During refresh(): Location is ${location.toString()}');

      final newState = await _getAllData(location, forceRefresh: true);
      debugPrint('Completed refresh(): Completed successfully: $newState');
      state = AsyncValue.data(newState);
    } catch (e, stackTrace) {
      debugPrint('During refresh(): Could not refresh. $e, $stackTrace');

      state = AsyncValue.data(current.copyWith(errorMessage: e.toString()));
    } finally {
      _isRefreshing = false;
    }
  }

  Future<void> clearState() async {
    try {
      final cacheService = ref.read(cacheServiceProvider);
      await Future.wait([
        cacheService.clearWeather(),
        cacheService.clearHourlyForecast(),
        cacheService.clearDailyForecast(),
      ]);
      state = const AsyncValue.data(WeatherState());
    } catch (e) {
      debugPrint('Error clearing state: $e');
    }
  }

  void clearError() {
    final current = state.value ?? const WeatherState();
    state = AsyncValue.data(current.copyWith(errorMessage: null));
  }

  bool isDay() {
    final weather = state.valueOrNull?.weather;
    if (weather?.sunrise == null ||
        weather?.sunset == null ||
        weather?.dt == null) {
      return true;
    }

    final sunriseTime = DateTime.fromMillisecondsSinceEpoch(
      weather!.sunrise * 1000,
    );

    final sunsetTime = DateTime.fromMillisecondsSinceEpoch(
      weather.sunset * 1000,
    );

    final currentTime = DateTime.fromMillisecondsSinceEpoch(weather.dt * 1000);

    return currentTime.isAfter(sunriseTime) && currentTime.isBefore(sunsetTime);
  }

  // viewmodel does not know info is coming from local or remote. we abstract with making cache decisions in repository layer.
  Future<WeatherState> _getAllData(
    LocationModel location, {
    bool forceRefresh = false,
  }) async {
    try {
      final languageCode = ref.read(languageCodeProvider);
      debugPrint('During _getAllData(): Language code is -$languageCode-');
      final current = state.valueOrNull ?? const WeatherState();
      final isConnected = await _isConnected();
      if (!isConnected) {
        return current.copyWith(hasInternet: false);
      }

      final futures = await Future.wait([
        _weatherRepository
            .getWeather(
              location,
              lang: languageCode,
              forceRefresh: forceRefresh,
            )
            .timeout(DurationConstants.networkTtl),
        _weatherRepository
            .getHourlyForecast(location, forceRefresh: forceRefresh)
            .timeout(DurationConstants.networkTtl),
        _weatherRepository
            .getDailyForecast(location, forceRefresh: forceRefresh)
            .timeout(DurationConstants.networkTtl),
      ]);

      final weatherModel = futures[0] as WeatherModel;
      final hourlyData = futures[1] as HourlyForecastPacket;
      final dailyData = futures[2] as DailyForecastPacket;

      final weather = weatherModel.copyWith(uniqueKey: location.uniqueKey);
      final hourly = hourlyData.copyWith(uniqueKey: location.uniqueKey);
      final daily = dailyData.copyWith(uniqueKey: location.uniqueKey);

      debugPrint('Completed _getAllData(): Completed successfully');

      return current.copyWith(
        weather: weather,
        hourlyForecasts: hourly,
        dailyForecasts: daily,
        errorMessage: null,
        hasInternet: true,
      );
    } catch (e, stackTrace) {
      debugPrint(
        'During _getAllData(): Could not get all data. $e, $stackTrace',
      );
      rethrow;
    }
  }

  Future<void> _refreshWeather(LocationModel loc, String code) async {
    if (_isRefreshing) {
      debugPrint(
        'During _refreshWeather(): Refresh already in progress, skipping...',
      );
      return;
    }
    _isRefreshing = true;

    try {
      final current = state.valueOrNull ?? const WeatherState();

      final isConnected = await _isConnected();
      if (!isConnected) {
        state = AsyncValue.data(current.copyWith(hasInternet: false));
        return;
      }

      final weather = await _weatherRepository
          .getWeather(loc, lang: code, forceRefresh: true)
          .timeout(DurationConstants.networkTtl);

      final updatedWeather = weather.copyWith(uniqueKey: loc.uniqueKey);

      debugPrint(
        'Finished _refreshWeather(): Completed successfully. $updatedWeather',
      );
      state = AsyncValue.data(
        current.copyWith(weather: updatedWeather, hasInternet: true),
      );
    } catch (e) {
      debugPrint('During _refreshWeather(): Could not refresh weather. $e');
    } finally {
      _isRefreshing = false;
    }
  }

  Future<bool> _isConnected() async {
    return _networkService.isConnected;
  }

  void _attachListeners() {
    ref.listen<LocationModel?>(
      locationNotifierProvider.select((s) => s.value?.location),
      (prev, next) {
        if (!_isRefreshing && next != null) {
          debugPrint('Location listener is changed. $next');
          refresh();
        }
      },
      fireImmediately: false,
    );

    ref.listen<Locale?>(localeProvider, (prev, next) {
      if (!_isRefreshing &&
          prev != null &&
          next != null &&
          prev.languageCode != next.languageCode) {
        final loc = ref.read(locationNotifierProvider).value?.location;
        if (loc != null) {
          debugPrint('Unit listener is changed. $next');
          _refreshWeather(loc, next.languageCode);
        }
      }
    }, fireImmediately: false);
  }
}

final weatherViewModelProvider =
    AsyncNotifierProvider<WeatherViewModel, WeatherState>(() {
      return WeatherViewModel();
    });
