import 'package:project_weather/app/constants/hive_constants.dart';
import 'package:project_weather/shared/helpers/parse_helper.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'weather_model.g.dart';

@HiveType(typeId: HiveConstants.weatherTypeId)
class WeatherModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String main;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String iconCode;
  @HiveField(4)
  final double temp;
  @HiveField(5)
  final double feelsLike;
  @HiveField(6)
  final int pressure;
  @HiveField(7)
  final int humidity;
  @HiveField(8)
  final int visibility;
  @HiveField(9)
  final double speed;
  @HiveField(10)
  final int degree;
  @HiveField(11)
  final int clouds;
  @HiveField(12)
  final double rain;
  @HiveField(13)
  final double snow;
  @HiveField(14)
  final int sunrise;
  @HiveField(15)
  final int sunset;
  @HiveField(16)
  final int dt;
  @HiveField(17)
  final int timezone;

  @HiveField(18)
  final String uniqueKey;

  WeatherModel({
    required this.id,
    required this.main,
    required this.description,
    required this.iconCode,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.visibility,
    required this.speed,
    required this.degree,
    required this.clouds,
    required this.rain,
    required this.snow,
    required this.sunrise,
    required this.sunset,
    required this.dt,
    required this.timezone,
    String? uniqueKey,
  }) : uniqueKey = uniqueKey ?? '';

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      id: ParseHelper.parseInt(json['weather']?[0]?['id']),
      main: json['weather']?[0]?['main'],
      description: json['weather']?[0]?['description'] ?? 'Unknown',
      iconCode: json['weather']?[0]?['icon'] ?? '01d',

      temp: ParseHelper.parseDouble(json['main']?['temp']),
      feelsLike: ParseHelper.parseDouble(json['main']?['feels_like']),
      pressure: ParseHelper.parseInt(json['main']?['pressure']),
      humidity: ParseHelper.parseInt(json['main']?['humidity']),

      visibility: ParseHelper.parseInt(json['visibility']),

      speed: ParseHelper.parseDouble(json['wind']?['speed']),
      degree: ParseHelper.parseInt(json['wind']?['deg']),

      clouds: ParseHelper.parseInt(json['clouds']?['all']),

      rain: ParseHelper.parseDouble(
        json['rain']?['1h'] ?? json['rain']?['3h'] ?? 0,
      ),

      snow: ParseHelper.parseDouble(
        json['snow']?['1h'] ?? json['snow']?['3h'] ?? 0,
      ),

      dt: ParseHelper.parseInt(json['dt']),

      sunrise: ParseHelper.parseInt(json['sys']?['sunrise']),
      sunset: ParseHelper.parseInt(json['sys']?['sunset']),

      timezone: ParseHelper.parseInt(json['timezone']),
    );
  }

  WeatherModel copyWith({
    int? id,
    String? main,
    String? description,
    String? iconCode,
    double? temp,
    double? feelsLike,
    int? pressure,
    int? humidity,
    int? clouds,
    int? visibility,
    double? speed,
    int? degree,
    double? rain,
    double? snow,
    int? dt,
    int? sunrise,
    int? sunset,
    int? timezone,
    String? uniqueKey,
  }) {
    return WeatherModel(
      id: id ?? this.id,
      main: main ?? this.main,
      description: description ?? this.description,
      iconCode: iconCode ?? this.iconCode,
      temp: temp ?? this.temp,
      feelsLike: feelsLike ?? this.feelsLike,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      clouds: clouds ?? this.clouds,
      visibility: visibility ?? this.visibility,
      speed: speed ?? this.speed,
      degree: degree ?? this.degree,
      rain: rain ?? this.rain,
      snow: snow ?? this.snow,
      dt: dt ?? this.dt,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
      timezone: timezone ?? this.timezone,
      uniqueKey: uniqueKey ?? this.uniqueKey,
    );
  }
}
