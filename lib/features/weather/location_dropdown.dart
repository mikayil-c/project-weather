import 'package:flutter/material.dart';
import 'package:project_weather/l10n/app_localizations.dart';
import 'package:project_weather/models/model/location_model.dart';
import 'package:project_weather/shared/providers/location_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationDropdown extends ConsumerWidget {
  const LocationDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedLocations =
        ref.watch(
          locationNotifierProvider.select(
            (state) => state.value?.savedLocations,
          ),
        ) ??
        [];

    final location = ref.watch(
      locationNotifierProvider.select((s) => s.value?.location),
    );

    return savedLocations.isEmpty
        ? Text(AppLocalizations.of(context)!.noSavedLocations)
        : DropdownButtonHideUnderline(
            child: DropdownButton<LocationModel>(
              isExpanded: true,
              alignment: AlignmentDirectional.center,
              enableFeedback: false,
              value: location,
              dropdownColor: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(12.0),
              iconEnabledColor: Colors.grey.shade100,
              items: savedLocations.map((loc) {
                return DropdownMenuItem<LocationModel>(
                  alignment: Alignment.center,
                  value: loc,
                  child: Text(
                    loc.name,
                    style: TextTheme.of(context).headlineMedium!.copyWith(
                      color: Colors.grey.shade100,
                      fontWeight: loc == location
                          ? FontWeight.normal
                          : FontWeight.w300,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (LocationModel? selectedLocation) async {
                if (selectedLocation == null) return;
                if (selectedLocation == location) return;

                await ref
                    .read(locationNotifierProvider.notifier)
                    .changeLocation(selectedLocation);
              },
            ),
          );
  }
}
