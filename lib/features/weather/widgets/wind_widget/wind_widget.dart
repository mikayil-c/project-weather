import 'package:flutter/material.dart';
import 'package:project_weather/features/weather/widgets/shared/medium_item_container.dart';
import 'package:project_weather/models/app_models/wind.dart';
import 'package:project_weather/shared/providers/settings_provider.dart';
import 'package:project_weather/shared/viewmodels/weather_view_model.dart';
import 'package:project_weather/features/weather/widgets/wind_widget/wind_direction.dart';
import 'package:project_weather/features/weather/widgets/shared/item_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WindWidget extends ConsumerWidget {
  const WindWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int? degree = ref.watch(
      weatherViewModelProvider.select((state) => state.value?.weather?.degree),
    );
    final double? speed = ref.watch(
      weatherViewModelProvider.select((state) => state.value?.weather?.speed),
    );

    if (degree == null || speed == null) {
      return ItemContainer(child: Row(children: [Text('')]));
    }

    final Wind category = ref.read(formatHelperProvider).getWindCategory(speed);

    final formattedSpeed = ref.watch(formatHelperProvider).formatSpeed(speed);

    return MediumItemContainer(
      title: category.getTitle(context),
      value: formattedSpeed,
      text: category.getInfo(context),
      widget: WindDirection(degree: degree),
    );
  }
}
