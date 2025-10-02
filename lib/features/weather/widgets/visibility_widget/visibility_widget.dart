import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_weather/features/weather/widgets/shared/medium_item_container.dart';
import 'package:project_weather/models/app_models/distance.dart';
import 'package:project_weather/shared/providers/settings_provider.dart';
import 'package:project_weather/shared/viewmodels/weather_view_model.dart';
import 'package:project_weather/features/weather/widgets/shared/item_container.dart';
import 'package:project_weather/features/weather/widgets/visibility_widget/animated_triangle.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VisibilityWidget extends ConsumerWidget {
  const VisibilityWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int? visibility = ref.watch(
      weatherViewModelProvider.select(
        (state) => state.value?.weather?.visibility,
      ),
    );

    if (visibility == null) {
      return ItemContainer(height: 150, child: Row(children: [Text('')]));
    }

    final Distance category = ref
        .read(formatHelperProvider)
        .getDistanceCategory(visibility);

    final formattedVisibility = ref
        .watch(formatHelperProvider)
        .formatDistance(visibility.toDouble());

    return MediumItemContainer(
      title: category.getTitle(context),
      value: formattedVisibility,
      text: category.getInfo(context),
      widget: VisibilityIcon(visibility: visibility),
    );
  }
}

class VisibilityIcon extends StatelessWidget {
  final int visibility;
  static const int maxDistance = 10000;

  const VisibilityIcon({super.key, required this.visibility});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi,
      child: AnimatedTriangle(
        targetFillPercentage: (visibility / maxDistance).clamp(0.0, 1.0),
        fillColor: Colors.blue,
        emptyColor: Colors.grey,
      ),
    );
  }
}
