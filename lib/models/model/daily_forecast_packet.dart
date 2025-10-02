import 'package:project_weather/app/constants/hive_constants.dart';
import 'package:project_weather/models/model/daily_forecast_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'daily_forecast_packet.g.dart';

@HiveType(typeId: HiveConstants.dailyForecastPacketTypeId)
class DailyForecastPacket extends HiveObject {
  @HiveField(0)
  final List<DailyForecastModel> list;

  @HiveField(1)
  final int fetchedAt;

  @HiveField(2)
  final String? uniqueKey;

  @HiveField(3)
  final int timezone;

  DailyForecastPacket({
    required this.list,
    int? fetchedAt,
    this.uniqueKey,
    required this.timezone,
  }) : fetchedAt = fetchedAt ?? DateTime.now().millisecondsSinceEpoch;

  DailyForecastPacket copyWith({
    List<DailyForecastModel>? list,
    int? fetchedAt,
    String? uniqueKey,
    int? timezone,
  }) {
    return DailyForecastPacket(
      list: list ?? this.list,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      uniqueKey: uniqueKey ?? this.uniqueKey,
      timezone: timezone ?? this.timezone,
    );
  }
}
