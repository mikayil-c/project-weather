import 'package:flutter/material.dart';
import 'package:project_weather/app/constants/hive_constants.dart';
import 'package:project_weather/l10n/app_localizations.dart';
import 'package:project_weather/l10n/l10n.dart';
import 'package:project_weather/models/model/daily_forecast_model.dart';
import 'package:project_weather/models/model/daily_forecast_packet.dart';
import 'package:project_weather/models/model/hourly_forecast_model.dart';
import 'package:project_weather/models/model/hourly_forecast_packet.dart';
import 'package:project_weather/models/model/location_model.dart';
import 'package:project_weather/models/state/settings_state.dart';
import 'package:project_weather/models/model/unit_model.dart';
import 'package:project_weather/models/model/weather_model.dart';
import 'package:project_weather/shared/providers/settings_provider.dart';
import 'package:project_weather/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  // have to register adapters before we use boxes
  Hive.registerAdapter(SettingsStateAdapter());
  Hive.registerAdapter(UnitModelAdapter());
  Hive.registerAdapter(LocationModelAdapter());
  Hive.registerAdapter(WeatherModelAdapter());
  Hive.registerAdapter(HourlyForecastModelAdapter());
  Hive.registerAdapter(DailyForecastModelAdapter());
  Hive.registerAdapter(DailyForecastPacketAdapter());
  Hive.registerAdapter(HourlyForecastPacketAdapter());

  // only opening settings box in main because it is necessary for language and unit
  await Hive.openBox<SettingsState>(HiveConstants.settingsBoxName);

  await dotenv.load(fileName: ".env");

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // the last time i checked, i had to read settings provider before start the app. i did not try afterwards.
    ref.read(settingsProvider);

    Locale locale = ref.watch(localeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: L10n.all.values,
      locale: locale,
      builder: (context, child) {
        AppLocalizations.of(context)!;
        return child!;
      },
      home: const SplashScreen(),
    );
  }
}
