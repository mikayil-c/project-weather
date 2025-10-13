import 'package:flutter/material.dart';
import 'package:project_weather/shared/viewmodels/weather_view_model.dart';
import 'package:project_weather/features/weather/widgets/shared/weather_icon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentWeatherIcon extends ConsumerWidget {
  const CurrentWeatherIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final iconCode = ref.watch(
      weatherViewModelProvider.select(
        (state) => state.value?.weather?.iconCode,
      ),
    );

    return WeatherIcon(iconCode: iconCode, size: 128);
  }
}
