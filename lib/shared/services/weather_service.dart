import 'package:dio/dio.dart';
import 'package:project_weather/shared/helpers/parse_helper.dart';
import 'package:project_weather/models/model/daily_forecast_model.dart';
import 'package:project_weather/models/model/daily_forecast_packet.dart';
import 'package:project_weather/models/model/hourly_forecast_model.dart';
import 'package:project_weather/models/model/hourly_forecast_packet.dart';
import 'package:project_weather/models/model/weather_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherService {
  final Dio _dio;

  WeatherService(this._dio);

  Future<WeatherModel> fetchWeather(double lat, double lon, String lang) async {
    try {
      final response = await _dio.get(
        '${dotenv.env['OWM_BASE_URL']}/data/2.5/weather',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': dotenv.env['API_KEY'],
          'lang': lang,
        },
      );

      final Map<String, dynamic> data = response.data;

      return WeatherModel.fromJson(data);
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Failed to fetch weather data');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<DailyForecastPacket> fetchDailyForecast(double lat, double lon) async {
    try {
      final response = await _dio.get(
        '${dotenv.env['OWM_BASE_URL']}/data/2.5/forecast/daily',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'cnt': 14,
          'appid': dotenv.env['API_KEY'],
        },
      );

      final data = response.data;

      final List<dynamic> jsonList = data['list'] as List<dynamic>;

      final list = jsonList
          .map((i) => DailyForecastModel.fromJson(i as Map<String, dynamic>))
          .toList();
      final timezone = ParseHelper.parseInt(data['city']?['timezone']);

      final dailyForecast = DailyForecastPacket(list: list, timezone: timezone);
      return dailyForecast;
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Failed to fetch daily forecast');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<HourlyForecastPacket> fetchHourlyForecast(
    double lat,
    double lon,
  ) async {
    try {
      final response = await _dio.get(
        '${dotenv.env['OWM_BASE_URL']}/data/2.5/forecast/hourly',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'cnt': 24,
          'appid': dotenv.env['API_KEY'],
        },
      );

      final data = response.data;

      final List<dynamic> jsonList = data['list'] as List<dynamic>;

      final list = jsonList
          .map((i) => HourlyForecastModel.fromJson(i as Map<String, dynamic>))
          .toList();

      final timezone = ParseHelper.parseInt(data['city']?['timezone']);
      final sunrise = ParseHelper.parseInt(data['city']?['sunrise']);
      final sunset = ParseHelper.parseInt(data['city']?['sunset']);

      final hourlyForecast = HourlyForecastPacket(
        list: list,
        timezone: timezone,
        sunrise: sunrise,
        sunset: sunset,
      );
      return hourlyForecast;
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Failed to fetch hourly forecast');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
