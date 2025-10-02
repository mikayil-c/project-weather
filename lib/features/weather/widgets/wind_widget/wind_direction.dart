import 'package:flutter/material.dart';
import 'package:project_weather/features/weather/widgets/wind_widget/compass.dart';

class WindDirection extends StatelessWidget {
  final int degree;
  const WindDirection({super.key, required this.degree});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 150, height: 150, child: Compass(degree: degree));
  }
}
