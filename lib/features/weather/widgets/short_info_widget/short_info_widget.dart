import 'package:flutter/material.dart';
import 'package:project_weather/features/weather/widgets/short_info_widget/widgets/last_update.dart';
import 'package:project_weather/features/weather/widgets/shared/item_container.dart';
import 'package:project_weather/features/weather/widgets/short_info_widget/widgets/current_weather_icon.dart';
import 'package:project_weather/features/weather/widgets/short_info_widget/widgets/weather_description.dart';
import 'package:project_weather/features/weather/widgets/short_info_widget/widgets/weather_feelslike_temperature.dart';
import 'package:project_weather/features/weather/widgets/short_info_widget/widgets/weather_temperature.dart';
import 'package:project_weather/shared/viewmodels/weather_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShortInfoWidget extends ConsumerWidget {
  const ShortInfoWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weather = ref.watch(
      weatherViewModelProvider.select((state) => state.valueOrNull?.weather),
    );

    if (weather == null) return const SizedBox(height: 120);

    return const ItemContainer(
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WeatherTemperature(),
                    WeatherFeelslikeTemperature(),
                    WeatherDescription(),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CurrentWeatherIcon(), LastUpdateTime()],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
