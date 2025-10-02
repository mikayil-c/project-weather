import 'package:flutter/material.dart';
import 'package:project_weather/shared/widgets/loading_skeleton.dart';
import 'package:project_weather/shared/viewmodels/weather_view_model.dart';
import 'package:project_weather/features/weather/widgets/daily_widget/daily_list.dart';
import 'package:project_weather/features/weather/widgets/shared/item_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DailyWidget extends ConsumerWidget {
  const DailyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packet = ref.watch(
      weatherViewModelProvider.select((state) => state.value?.dailyForecasts),
    );

    return ItemContainer(
      child: packet == null
          ? LoadingSkeleton(height: 420)
          : DailyList(packet: packet),
    );
  }
}
