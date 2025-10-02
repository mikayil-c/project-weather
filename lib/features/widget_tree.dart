import 'package:flutter/material.dart';
import 'package:project_weather/l10n/app_localizations.dart';
import 'package:project_weather/models/state/app_startup_state.dart';
import 'package:project_weather/shared/providers/app_startup_provider.dart';
import 'package:project_weather/shared/widgets/loading_screen.dart';
import 'package:project_weather/shared/widgets/error_screen.dart';
import 'package:project_weather/features/intro/intro.dart';
import 'package:project_weather/features/weather/weather.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WidgetTree extends ConsumerWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startupState = ref.watch(appStartupProvider);

    return startupState.when(
      loading: () =>
          LoadingScreen(message: AppLocalizations.of(context)!.lookingToSky),
      error: (e, stackTrace) => ErrorScreen(
        title: AppLocalizations.of(context)!.startingFeelsWrong,
        message: AppLocalizations.of(context)!.pleaseTryAgain,
        onRetry: ref.read(appStartupProvider.notifier).retryStartupCheck,
      ),
      data: (state) => IntroData(state: state),
    );
  }
}

class IntroData extends StatelessWidget {
  final AppStartupState state;
  const IntroData({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case AppStartupState.intro:
        return const Intro();
      case AppStartupState.home:
        return const Weather();
    }
  }
}
