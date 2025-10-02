import 'package:flutter/material.dart';
import 'package:project_weather/app/constants/text_constants.dart';
import 'package:project_weather/models/model/hourly_forecast_model.dart';
import 'package:project_weather/features/weather/widgets/shared/percent_icon.dart';
import 'package:project_weather/features/weather/widgets/shared/weather_icon.dart';

class HourlyForecastItem extends StatelessWidget {
  final HourlyForecastModel hourData;
  final String Function(int dt) formatTime;
  final String Function(double temp) formatTemp;

  const HourlyForecastItem({
    super.key,
    required this.hourData,
    required this.formatTime,
    required this.formatTemp,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.18,
      decoration: BoxDecoration(
        color: const Color.fromARGB(10, 255, 255, 255),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(formatTime(hourData.dt), style: TextConstants.hourlyInfoTitle),
          PercentIcon(
            icon: Icons.water_drop_sharp,
            percentage: hourData.pop,
            size: 16,
          ),
          if (hourData.iconCode.isNotEmpty)
            WeatherIcon(iconCode: hourData.iconCode, size: 42),
          Text(formatTemp(hourData.temp), style: TextConstants.hourlyInfoText),
        ],
      ),
    );
  }
}
