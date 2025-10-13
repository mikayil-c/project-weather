import 'package:flutter/material.dart';
import 'package:project_weather/features/weather/widgets/shared/small_item_container.dart';
import 'package:project_weather/models/app_models/pressure.dart';
import 'package:project_weather/shared/providers/settings_provider.dart';
import 'package:project_weather/shared/viewmodels/weather_view_model.dart';
import 'package:project_weather/features/weather/widgets/shared/item_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PressureWidget extends ConsumerWidget {
  const PressureWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pressure = ref.watch(
      weatherViewModelProvider.select(
        (state) => state.value?.weather?.pressure,
      ),
    );

    if (pressure == null) {
      return ItemContainer(height: 150, child: Row(children: [Text('')]));
    }

    final Pressure category = ref
        .read(formatHelperProvider)
        .getPressureCategory(pressure);

    final formattedPressure = ref
        .read(formatHelperProvider)
        .formatPressure(pressure);

    final percentage = (pressure - 980) / (1050 - 980);

    return SmallItemContainer(
      title: 'Pressure',
      text: category.getTitle(context),
      info: category.getInfo(context),
      value: formattedPressure,
      percentage: percentage,
      icon: Icons.download_outlined,
    );
  }
}
