import 'package:flutter/material.dart';
import 'package:project_weather/features/weather/weather_app_bar.dart';
import 'package:project_weather/features/weather/weather_content.dart';

class Weather extends StatelessWidget {
  const Weather({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: WeatherAppBar(),
      body: WeatherMainContent(),
    );
  }
}
