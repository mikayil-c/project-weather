import 'package:project_weather/app/constants/hive_constants.dart';
import 'package:project_weather/models/model/hourly_forecast_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'hourly_forecast_packet.g.dart';

@HiveType(typeId: HiveConstants.hourlyForecastPacketTypeId)
class HourlyForecastPacket extends HiveObject {
  @HiveField(0)
  final List<HourlyForecastModel> list;

  @HiveField(1)
  final int fetchedAt;

  @HiveField(2)
  final String? uniqueKey;

  @HiveField(3)
  final int timezone;

  @HiveField(4)
  final int sunrise;

  @HiveField(5)
  final int sunset;

  HourlyForecastPacket({
    required this.list,
    this.uniqueKey,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
    int? fetchedAt,
  }) : fetchedAt = fetchedAt ?? DateTime.now().millisecondsSinceEpoch;

  HourlyForecastPacket copyWith({
    List<HourlyForecastModel>? list,
    String? uniqueKey,
    int? timezone,
    int? sunrise,
    int? sunset,
    int? fetchedAt,
  }) {
    return HourlyForecastPacket(
      list: list ?? this.list,
      uniqueKey: uniqueKey ?? this.uniqueKey,
      timezone: timezone ?? this.timezone,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
      fetchedAt: fetchedAt ?? this.fetchedAt,
    );
  }
}
