import 'package:flutter/material.dart';

import 'package:project_weather/features/settings/widgets/reset_button.dart';
import 'package:project_weather/features/settings/widgets/settings_item.dart';
import 'package:project_weather/l10n/app_localizations.dart';
import 'package:project_weather/l10n/l10n.dart';
import 'package:project_weather/models/model/unit_model.dart';
import 'package:project_weather/shared/providers/location_provider.dart';
import 'package:project_weather/shared/providers/settings_provider.dart';
import 'package:project_weather/shared/viewmodels/weather_view_model.dart';
import 'package:project_weather/features/settings/widgets/locale_dialog.dart';
import 'package:project_weather/features/settings/widgets/unit_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  @override
  Widget build(BuildContext context) {
    final selectedUnit = ref.watch(unitProvider);
    final selectedLocale = ref.watch(localeProvider);

    final selectedName = L10n.all.entries
        .firstWhere(
          (e) => e.value.languageCode == selectedLocale.languageCode,
          orElse: () => const MapEntry('', Locale('en')),
        )
        .key;

    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(localizations.settings),
        forceMaterialTransparency: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          SettingsItem(
            leading: const Icon(Icons.thermostat_rounded),
            title: localizations.unit,
            subtitle: selectedUnit.getText(context),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => UnitDialog(
                  localizations: localizations,
                  selectedUnit: selectedUnit,
                  onChanged: ref.read(settingsProvider.notifier).updateUnit,
                ),
              );
            },
          ),
          SettingsItem(
            leading: const Icon(Icons.translate_rounded),
            title: localizations.language,
            subtitle: selectedName,
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => LocaleDialog(
                  localizations: localizations,
                  currentCode: selectedLocale.languageCode,
                  onUpdate: ref.read(settingsProvider.notifier).updateLocale,
                ),
              );
            },
          ),

          const Divider(height: 24),

          ResetButton(
            onClear: () async {
              await ref.read(locationNotifierProvider.notifier).clearState();
              await ref.read(weatherViewModelProvider.notifier).clearState();
            },
          ),
        ],
      ),
    );
  }
}
