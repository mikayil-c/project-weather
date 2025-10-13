import 'package:project_weather/models/model/daily_forecast_packet.dart';
import 'package:project_weather/models/model/hourly_forecast_packet.dart';
import 'package:project_weather/models/model/weather_model.dart';

class WeatherState {
  final WeatherModel? weather;
  final HourlyForecastPacket? hourlyForecasts;
  final DailyForecastPacket? dailyForecasts;
  final String? errorMessage;
  final bool hasInternet;

  const WeatherState({
    this.weather,
    this.hourlyForecasts,
    this.dailyForecasts,
    this.errorMessage,
    this.hasInternet = true,
  });

  WeatherState copyWith({
    WeatherModel? weather,
    HourlyForecastPacket? hourlyForecasts,
    DailyForecastPacket? dailyForecasts,
    String? errorMessage,
    bool? hasInternet,
  }) {
    return WeatherState(
      weather: weather ?? this.weather,
      hourlyForecasts: hourlyForecasts ?? this.hourlyForecasts,
      dailyForecasts: dailyForecasts ?? this.dailyForecasts,
      errorMessage: errorMessage,
      hasInternet: hasInternet ?? this.hasInternet,
    );
  }
}
