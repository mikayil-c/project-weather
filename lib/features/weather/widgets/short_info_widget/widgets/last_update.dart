import 'package:flutter/material.dart';
import 'package:project_weather/app/constants/text_constants.dart';
import 'package:project_weather/l10n/app_localizations.dart';
import 'package:project_weather/shared/providers/settings_provider.dart';
import 'package:project_weather/shared/viewmodels/weather_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LastUpdateTime extends ConsumerWidget {
  const LastUpdateTime({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dt = ref.watch(
      weatherViewModelProvider.select((state) => state.value?.weather?.dt),
    );
    final timezone = ref.watch(
      weatherViewModelProvider.select(
        (state) => state.value?.weather?.timezone,
      ),
    );
    if (dt == null || timezone == null) {
      return const Text(' ');
    }

    final formattedDt = ref
        .read(formatHelperProvider)
        .formatTimeForClock(dt, timezone);

    return Text(
      '${AppLocalizations.of(context)!.latest}: $formattedDt',
      style: TextConstants.shortInfoDetail,
    );
  }
}
