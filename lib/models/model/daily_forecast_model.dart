import 'package:project_weather/app/constants/hive_constants.dart';
import 'package:project_weather/shared/helpers/parse_helper.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'daily_forecast_model.g.dart';

@HiveType(typeId: HiveConstants.dailyForecastTypeId)
class DailyForecastModel extends HiveObject {
  @HiveField(0)
  final int timezone;
  @HiveField(1)
  final int dt;
  @HiveField(2)
  final double min;
  @HiveField(3)
  final double max;
  @HiveField(4)
  final double feelsLike;
  @HiveField(5)
  final int pressure;
  @HiveField(6)
  final int humidity;
  @HiveField(7)
  final int id;
  @HiveField(8)
  final String main;
  @HiveField(9)
  final String description;
  @HiveField(10)
  final String iconCode;
  @HiveField(11)
  final double speed;
  @HiveField(12)
  final int degree;
  @HiveField(13)
  final int clouds;
  @HiveField(14)
  final double rain;
  @HiveField(15)
  final double snow;
  @HiveField(16)
  final double pop;

  DailyForecastModel({
    required this.timezone,
    required this.dt,
    required this.min,
    required this.max,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.id,
    required this.main,
    required this.description,
    required this.iconCode,
    required this.speed,
    required this.degree,
    required this.clouds,
    required this.rain,
    required this.snow,
    required this.pop,
  });

  factory DailyForecastModel.fromJson(Map<String, dynamic> json) {
    return DailyForecastModel(
      timezone: ParseHelper.parseInt(json['timezone']),
      dt: ParseHelper.parseInt(json['dt']),
      min: ParseHelper.parseDouble(json['temp']?['min']),
      max: ParseHelper.parseDouble(json['temp']?['max']),
      feelsLike: ParseHelper.parseDouble(json['temp']?['feels_like']),
      pressure: ParseHelper.parseInt(json['pressure']),
      humidity: ParseHelper.parseInt(json['humidity']),
      id: ParseHelper.parseInt(json['weather']?[0]?['id']),
      main: json['weather']?[0]?['main'],
      description: json['weather']?[0]?['description'],
      iconCode: json['weather']?[0]?['icon'] ?? '01d',
      speed: ParseHelper.parseDouble(json['speed']),
      degree: ParseHelper.parseInt(json['deg']),
      clouds: ParseHelper.parseInt(json['clouds']),
      rain: ParseHelper.parseDouble(json['rain']),
      snow: ParseHelper.parseDouble(json['snow']),
      pop: ParseHelper.parseDouble(json['pop']),
    );
  }

  DailyForecastModel copyWith({
    int? timezone,
    int? dt,
    double? min,
    double? max,
    double? feelsLike,
    int? pressure,
    int? humidity,
    int? id,
    String? main,
    String? description,
    String? iconCode,
    double? speed,
    int? degree,
    int? clouds,
    double? rain,
    double? snow,
    double? pop,
  }) {
    return DailyForecastModel(
      timezone: timezone ?? this.timezone,
      dt: dt ?? this.dt,
      min: min ?? this.min,
      max: max ?? this.max,
      feelsLike: feelsLike ?? this.feelsLike,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      id: id ?? this.id,
      main: main ?? this.main,
      description: description ?? this.description,
      iconCode: iconCode ?? this.iconCode,
      speed: speed ?? this.speed,
      degree: degree ?? this.degree,
      clouds: clouds ?? this.clouds,
      rain: rain ?? this.rain,
      snow: snow ?? this.snow,
      pop: pop ?? this.pop,
    );
  }
}
