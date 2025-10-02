import 'package:flutter/material.dart';
import 'package:project_weather/app/constants/gradient_constants.dart';
import 'package:project_weather/l10n/app_localizations.dart';
import 'package:project_weather/shared/widgets/error_screen.dart';
import 'package:project_weather/shared/viewmodels/weather_view_model.dart';
import 'package:project_weather/features/location_selection/location_selection.dart';
import 'package:project_weather/features/weather/widgets/daily_widget/daily_widget.dart';
import 'package:project_weather/features/weather/widgets/hourly_widget/hourly_widget.dart';
import 'package:project_weather/features/weather/widgets/humidity_widget/humidity_widget.dart';
import 'package:project_weather/features/weather/widgets/pressure_widget/pressure_widget.dart';
import 'package:project_weather/features/weather/widgets/short_info_widget/short_info_widget.dart';
import 'package:project_weather/features/weather/widgets/visibility_widget/visibility_widget.dart';
import 'package:project_weather/features/weather/widgets/wind_widget/wind_widget.dart';
import 'package:project_weather/shared/widgets/loading_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyContent extends ConsumerStatefulWidget {
  const MyContent({super.key});

  @override
  ConsumerState<MyContent> createState() => _MyContentState();
}

class _MyContentState extends ConsumerState<MyContent> {
  @override
  Widget build(BuildContext context) {
    final mainState = ref.watch(weatherViewModelProvider);
    final dt = ref.watch(
      weatherViewModelProvider.select((s) => s.valueOrNull?.weather?.dt),
    );
    final timezone = ref.watch(
      weatherViewModelProvider.select((s) => s.valueOrNull?.weather?.timezone),
    );
    final sunrise = ref.watch(
      weatherViewModelProvider.select((s) => s.valueOrNull?.weather?.sunrise),
    );
    final sunset = ref.watch(
      weatherViewModelProvider.select((s) => s.valueOrNull?.weather?.sunset),
    );

    final decoration = DecorationByTime.getGradientByTime(
      dt,
      timezone,
      sunrise,
      sunset,
    );

    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(seconds: 1),
          decoration: decoration,
          curve: Curves.easeInOut,
          child: SizedBox.expand(),
        ),

        Container(color: Colors.black.withValues(alpha: 0.3)),
        mainState.when(
          data: (state) {
            if (!state.hasInternet) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const Icon(
                          Icons.signal_wifi_connected_no_internet_4_rounded,
                        ),
                        Text(
                          AppLocalizations.of(
                            context,
                          )!.somethingWrongWithInternet,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // action: SnackBarAction(
                    //   label: localizations.tryAgain,
                    //   onPressed: () => ref
                    //       .read(locationSelectionViewModelProvider.notifier)
                    //       .searchLocations(_searchController.text),
                    // ),
                  ),
                );
              });
            }

            return WeatherContent(
              onRefresh: ref.read(weatherViewModelProvider.notifier).refresh,
            );
          },
          error: (e, stackTrace) {
            return ErrorScreen(
              message: e.toString(),
              onRetry: ref.read(weatherViewModelProvider.notifier).refresh,
              retryButtonText: AppLocalizations.of(context)!.tryAgain,
              additionalActions: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LocationSelection(),
                      ),
                    );
                  },
                  child: Text(AppLocalizations.of(context)!.selectLocation),
                ),
              ],
            );
          },
          loading: () {
            return LoadingScreen(
              message: AppLocalizations.of(context)!.lookingToSky,
            );
          },
        ),
      ],
    );
  }
}

class WeatherContent extends StatelessWidget {
  final Future<void> Function() onRefresh;
  const WeatherContent({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ShortInfoWidget(),
              HourlyWidget(),
              DailyWidget(),
              WindWidget(),
              Row(
                children: [
                  Expanded(child: HumidityWidget()),
                  Expanded(child: PressureWidget()),
                ],
              ),

              VisibilityWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
