import 'package:flutter/material.dart';
import 'package:project_weather/features/weather/widgets/shared/small_item_container.dart';
import 'package:project_weather/models/app_models/humidity.dart';
import 'package:project_weather/shared/providers/settings_provider.dart';
import 'package:project_weather/shared/viewmodels/weather_view_model.dart';
import 'package:project_weather/features/weather/widgets/shared/item_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HumidityWidget extends ConsumerWidget {
  const HumidityWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int? humidity = ref.watch(
      weatherViewModelProvider.select(
        (state) => state.value?.weather?.humidity,
      ),
    );

    if (humidity == null) {
      return ItemContainer(height: 150, child: Row(children: [Text('')]));
    }

    final Humidity category = ref
        .read(formatHelperProvider)
        .getHumidityCategory(humidity);

    return SmallItemContainer(
      title: 'Humidity',
      text: category.getTitle(context),
      value: '${humidity.toString()}%',
      info: category.getInfo(context),
      icon: Icons.water_drop_outlined,
      percentage: humidity / 100,
    );
  }
}
