import 'package:flutter/material.dart';
import 'package:project_weather/app/constants/hive_constants.dart';
import 'package:project_weather/models/model/daily_forecast_packet.dart';
import 'package:project_weather/models/model/hourly_forecast_packet.dart';
import 'package:project_weather/models/model/weather_model.dart';
import 'package:project_weather/shared/widgets/loading_screen.dart';
import 'package:project_weather/features/widget_tree.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    await Future.wait([
      Hive.openBox(HiveConstants.savedLocationsBoxName),
      Hive.openBox<WeatherModel>(HiveConstants.weatherBoxName),
      Hive.openBox<HourlyForecastPacket>(HiveConstants.hourlyForecastBoxName),
      Hive.openBox<DailyForecastPacket>(HiveConstants.dailyForecastBoxName),
    ]);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WidgetTree()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: LoadingScreen());
  }
}
