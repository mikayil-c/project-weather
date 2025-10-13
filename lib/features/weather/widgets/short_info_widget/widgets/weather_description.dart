import 'package:flutter/material.dart';
import 'package:project_weather/app/constants/text_constants.dart';
import 'package:project_weather/shared/viewmodels/weather_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherDescription extends ConsumerWidget {
  const WeatherDescription({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final description = ref.watch(
      weatherViewModelProvider.select(
        (state) => state.value?.weather?.description,
      ),
    );

    return Text(description ?? '--', style: TextConstants.shortInfoText);
  }
}
