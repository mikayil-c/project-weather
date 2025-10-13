import 'package:project_weather/app/constants/hive_constants.dart';
import 'package:project_weather/shared/helpers/parse_helper.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'hourly_forecast_model.g.dart';

@HiveType(typeId: HiveConstants.hourlyForecastTypeId)
class HourlyForecastModel extends HiveObject {
  @HiveField(0)
  final int dt;
  @HiveField(1)
  final double temp;
  @HiveField(2)
  final double feelsLike;
  @HiveField(3)
  final double min;
  @HiveField(4)
  final double max;
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
  final int clouds;
  @HiveField(12)
  final double speed;
  @HiveField(13)
  final int degree;
  @HiveField(14)
  final double rain;
  @HiveField(15)
  final double snow;
  @HiveField(16)
  final int visibility;
  @HiveField(17)
  final double pop;
  @HiveField(18)
  final String pod;
  @HiveField(19)
  final String dtTxt;

  HourlyForecastModel({
    required this.dt,
    required this.temp,
    required this.feelsLike,
    required this.min,
    required this.max,
    required this.pressure,
    required this.humidity,
    required this.id,
    required this.main,
    required this.description,
    required this.iconCode,
    required this.clouds,
    required this.speed,
    required this.degree,
    required this.rain,
    required this.snow,
    required this.visibility,
    required this.pop,
    required this.pod,
    required this.dtTxt,
  });

  factory HourlyForecastModel.fromJson(Map<String, dynamic> json) {
    return HourlyForecastModel(
      dt: ParseHelper.parseInt(json['dt']),
      temp: ParseHelper.parseDouble(json['main']?['temp']),
      feelsLike: ParseHelper.parseDouble(json['main']?['feels_like']),
      min: ParseHelper.parseDouble(json['main']?['temp_min']),
      max: ParseHelper.parseDouble(json['main']?['temp_max']),
      pressure: ParseHelper.parseInt(json['main']?['pressure']),
      humidity: ParseHelper.parseInt(json['main']?['humidity']),
      id: ParseHelper.parseInt(json['weather']?[0]?['id']),
      main: json['weather']?[0]?['main'],
      description: json['weather']?[0]?['description'],
      iconCode: json['weather']?[0]?['icon'],
      clouds: ParseHelper.parseInt(json['clouds']?['all']),
      speed: ParseHelper.parseDouble(json['wind']?['speed']),
      degree: ParseHelper.parseInt(json['wind']?['deg']),
      rain: ParseHelper.parseDouble(json['rain']?['1h']),
      snow: ParseHelper.parseDouble(json['snow']?['1h']),
      visibility: ParseHelper.parseInt(json['visibility']),
      pop: ParseHelper.parseDouble(json['pop']),
      pod: json['sys']?['pod'],
      dtTxt: json['dt_txt'],
    );
  }

  HourlyForecastModel copyWith({
    int? dt,
    double? temp,
    double? feelsLike,
    double? min,
    double? max,
    int? pressure,
    int? humidity,
    int? id,
    String? main,
    String? description,
    String? iconCode,
    int? clouds,
    double? speed,
    int? degree,
    double? rain,
    double? snow,
    int? visibility,
    double? pop,
    String? pod,
    String? dtTxt,
  }) {
    return HourlyForecastModel(
      dt: dt ?? this.dt,
      temp: temp ?? this.temp,
      feelsLike: feelsLike ?? this.feelsLike,
      min: min ?? this.min,
      max: max ?? this.max,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      id: id ?? this.id,
      main: main ?? this.main,
      description: description ?? this.description,
      iconCode: iconCode ?? this.iconCode,
      clouds: clouds ?? this.clouds,
      speed: speed ?? this.speed,
      degree: degree ?? this.degree,
      rain: rain ?? this.rain,
      snow: snow ?? this.snow,
      visibility: visibility ?? this.visibility,
      pop: pop ?? this.pop,
      pod: pod ?? this.pod,
      dtTxt: dtTxt ?? this.dtTxt,
    );
  }
}
