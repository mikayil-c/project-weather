import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  final String? iconCode;
  final double size;

  const WeatherIcon({super.key, this.iconCode, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
      child: ClipRRect(
        child: iconCode == null
            ? null
            : Image.network(
                'https://openweathermap.org/img/wn/$iconCode@2x.png',
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator.adaptive(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
      ),
    );
  }
}
