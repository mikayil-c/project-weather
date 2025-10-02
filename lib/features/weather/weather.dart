import 'package:flutter/material.dart';
import 'package:project_weather/features/weather/my_appbar.dart';
import 'package:project_weather/features/weather/my_content.dart';

class Weather extends StatelessWidget {
  const Weather({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppbar(),
      body: MyContent(),
    );
  }
}
