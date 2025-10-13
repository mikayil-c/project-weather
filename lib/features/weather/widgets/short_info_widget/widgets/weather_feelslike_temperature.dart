import 'package:flutter/material.dart';
import 'package:project_weather/app/constants/text_constants.dart';
import 'package:project_weather/l10n/app_localizations.dart';
import 'package:project_weather/shared/providers/settings_provider.dart';
import 'package:project_weather/shared/viewmodels/weather_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherFeelslikeTemperature extends ConsumerWidget {
  const WeatherFeelslikeTemperature({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feelslikeTemperatureC = ref.watch(
      weatherViewModelProvider.select(
        (state) => state.value?.weather?.feelsLike,
      ),
    );

    if (feelslikeTemperatureC == null) return Text('--');

    final localizations = AppLocalizations.of(context)!;

    return Text(
      '${localizations.feelsLike}: ${ref.watch(formatHelperProvider).formatTemperature(feelslikeTemperatureC)}',
      style: TextConstants.shortInfoText,
    );
  }
}
