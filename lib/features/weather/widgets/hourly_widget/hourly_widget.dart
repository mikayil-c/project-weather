import 'package:flutter/material.dart';
import 'package:project_weather/shared/providers/settings_provider.dart';
import 'package:project_weather/shared/widgets/loading_skeleton.dart';
import 'package:project_weather/shared/viewmodels/weather_view_model.dart';
import 'package:project_weather/features/weather/widgets/hourly_widget/hourly_list.dart';
import 'package:project_weather/features/weather/widgets/shared/item_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HourlyWidget extends ConsumerStatefulWidget {
  const HourlyWidget({super.key});

  @override
  ConsumerState<HourlyWidget> createState() => _HourlyWidgetState();
}

class _HourlyWidgetState extends ConsumerState<HourlyWidget> {
  @override
  Widget build(BuildContext context) {
    final packet = ref.watch(
      weatherViewModelProvider.select((state) => state.value!.hourlyForecasts),
    );
    final formatHelper = ref.watch(formatHelperProvider);

    return ItemContainer(
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: packet == null
                ? LoadingSkeleton()
                : HourlyList(packet: packet, formatHelper: formatHelper),
          ),
        ],
      ),
    );
  }
}
