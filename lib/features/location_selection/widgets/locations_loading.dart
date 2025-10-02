import 'package:flutter/material.dart';
import 'package:project_weather/l10n/app_localizations.dart';
import 'package:project_weather/shared/widgets/my_indicator.dart';

class LocationsLoading extends StatelessWidget {
  final AppLocalizations localizations;
  const LocationsLoading({super.key, required this.localizations});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyIndicator(),
          SizedBox(height: 16),
          Text(localizations.locSelectGettingInfos),
        ],
      ),
    );
  }
}
