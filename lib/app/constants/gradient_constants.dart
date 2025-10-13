import 'package:flutter/material.dart';

class AppDecorations {
  static final sunrise = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xFF0c1445),
        Color(0xFF3b3f79),
        Color(0xFFf88c4d),
        Color(0xFFffc977),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: const [0.0, 0.4, 0.8, 1.0],
    ),
  );

  static final morning = BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFF87CEEB), Color(0xFFB0E0E6)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );

  static final day = BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFF0077BE), Color(0xFF87CEFA)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: const [0.0, 1.0],
    ),
  );

  static final goldenHour = BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFF4682B4), Color(0xFFFFC300), Color(0xFFFF8C00)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: const [0.0, 0.6, 1.0],
    ),
  );

  static final fierySunset = BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFF2c3e50), Color(0xFFe74c3c), Color(0xFFf39c12)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: const [0.0, 0.2, 0.9],
    ),
  );

  static final twilightGlow = BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFF233354), Color(0xFF6A487A), Color(0xFFC06C84)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: const [0.0, 0.5, 1.0],
    ),
  );

  static final evening = BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFF141E30), Color(0xFF243B55)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );

  static final night = BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFF000428), Color(0xFF004e92)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );
}

class DecorationByTime {
  static BoxDecoration getGradientByTime(
    int? dt,
    int? timezone,
    int? sunrise,
    int? sunset,
  ) {
    if (dt == null || timezone == null || sunrise == null || sunset == null) {
      return AppDecorations.day;
    }

    final currentTime = DateTime.fromMillisecondsSinceEpoch(
      dt * 1000,
      isUtc: true,
    ).add(Duration(seconds: timezone));
    final sunriseTime = DateTime.fromMillisecondsSinceEpoch(
      sunrise * 1000,
      isUtc: true,
    ).add(Duration(seconds: timezone));
    final sunsetTime = DateTime.fromMillisecondsSinceEpoch(
      sunset * 1000,
      isUtc: true,
    ).add(Duration(seconds: timezone));

    final sunriseWindowStart = sunriseTime.subtract(
      const Duration(minutes: 30),
    );
    final sunriseWindowEnd = sunriseTime.add(const Duration(minutes: 60));

    final goldenHourStart = sunsetTime.subtract(const Duration(hours: 1));
    final fierySunsetStart = sunsetTime;
    final twilightGlowStart = sunsetTime.add(const Duration(minutes: 30));
    final twilightGlowEnd = sunsetTime.add(
      const Duration(hours: 1, minutes: 30),
    );
    final eveningEndHour = 23;

    if (currentTime.isAfter(goldenHourStart) &&
        currentTime.isBefore(twilightGlowEnd)) {
      if (currentTime.isBefore(fierySunsetStart)) {
        return AppDecorations.goldenHour;
      } else if (currentTime.isBefore(twilightGlowStart)) {
        return AppDecorations.fierySunset;
      } else {
        return AppDecorations.twilightGlow;
      }
    }

    if (currentTime.isAfter(sunriseWindowStart) &&
        currentTime.isBefore(sunriseWindowEnd)) {
      return AppDecorations.sunrise;
    }

    if (currentTime.isAfter(sunriseTime) && currentTime.isBefore(sunsetTime)) {
      final noon = sunriseTime.add(sunsetTime.difference(sunriseTime) ~/ 2);
      if (currentTime.isBefore(noon)) {
        return AppDecorations.morning;
      } else {
        return AppDecorations.day;
      }
    }

    if (currentTime.isAfter(twilightGlowEnd) &&
        currentTime.hour < eveningEndHour) {
      return AppDecorations.evening;
    } else {
      return AppDecorations.night;
    }
  }
}
