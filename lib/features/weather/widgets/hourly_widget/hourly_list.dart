import 'package:flutter/material.dart';
import 'package:project_weather/shared/helpers/format_helper.dart';
import 'package:project_weather/models/model/hourly_forecast_packet.dart';
import 'package:project_weather/features/weather/widgets/hourly_widget/hourly_forecast_item.dart';

class HourlyList extends StatelessWidget {
  final HourlyForecastPacket packet;
  final FormatHelper formatHelper;
  final String? s;

  const HourlyList({
    super.key,
    required this.packet,
    required this.formatHelper,
    this.s,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: packet.list.length,
      separatorBuilder: (_, _) => const SizedBox(width: 8),

      itemBuilder: (context, index) {
        final hourData = packet.list[index];
        return HourlyForecastItem(
          hourData: hourData,
          formatTemp: (temp) => formatHelper.formatTemperature(temp),
          formatTime: (dt) =>
              formatHelper.formatTimeForClock(dt, packet.timezone),
        );
      },
    );
  }
}
