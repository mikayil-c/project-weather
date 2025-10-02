import 'package:flutter/material.dart';
import 'package:project_weather/app/constants/text_constants.dart';
import 'package:project_weather/models/model/daily_forecast_model.dart';
import 'package:project_weather/shared/providers/settings_provider.dart';
import 'package:project_weather/features/weather/widgets/shared/percent_icon.dart';
import 'package:project_weather/features/weather/widgets/shared/weather_icon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DailyForecastItem extends ConsumerWidget {
  final DailyForecastModel dayData;

  const DailyForecastItem({super.key, required this.dayData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          // DAY NAME
          Expanded(
            flex: 4,
            child: Text(
              ref
                  .read(formatHelperProvider)
                  .formatTimeForDay(context, dayData.dt),
              style: TextConstants.dailyInfoTitle,
            ),
          ),

          // DAY WEATHER INFO
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // HIGHEST TEMPERATURE
                    Text(
                      ref
                          .watch(formatHelperProvider)
                          .formatTemperature(dayData.max),
                      style: TextConstants.dailyInfoText,
                    ),
                    const Text(' | ', style: TextConstants.dailyInfoText),

                    // LOWEST TEMPERATURE
                    Text(
                      ref
                          .read(formatHelperProvider)
                          .formatTemperature(dayData.min),
                      style: TextConstants.dailyInfoText,
                    ),
                    const SizedBox(width: 12.0),
                    PercentIcon(
                      icon: Icons.water_drop_sharp,
                      percentage: dayData.pop,
                      size: 16,
                    ),
                  ],
                ),
                if (dayData.iconCode.isNotEmpty)
                  WeatherIcon(iconCode: dayData.iconCode, size: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
