import 'package:flutter/material.dart';
import 'package:project_weather/app/constants/text_constants.dart';
import 'package:project_weather/shared/providers/settings_provider.dart';
import 'package:project_weather/shared/viewmodels/weather_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherTemperature extends ConsumerWidget {
  const WeatherTemperature({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double? temp = ref.watch(
      weatherViewModelProvider.select((state) => state.value?.weather?.temp),
    );

    if (temp == null) return const Text('--');

    return Text(
      ref
          .watch(formatHelperProvider)
          .formatTemperature(temp, isThereSymbol: true),
      style: TextConstants.shortInfoTitle,
    );
  }
}
