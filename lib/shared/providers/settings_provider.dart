import 'package:flutter/material.dart';
import 'package:project_weather/shared/helpers/settings_helper.dart';
import 'package:project_weather/models/state/settings_state.dart';
import 'package:project_weather/models/model/unit_model.dart';
import 'package:project_weather/shared/providers/service_providers.dart';
import 'package:project_weather/shared/helpers/format_helper.dart';
import 'package:project_weather/shared/services/settings_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//------------NOTIFIER------------
class SettingsNotifier extends AsyncNotifier<SettingsState> {
  SettingsService get _settingsService => ref.read(settingsServiceProvider);

  @override
  Future<SettingsState> build() async {
    return await _loadInitialSettings();
  }

  Future<SettingsState> _loadInitialSettings() async {
    try {
      final settings = _settingsService.getSettings();
      return settings.copyWith(
        unit: settings.unit ?? SettingsHelper.getSystemUnit(),
        localeCode:
            settings.localeCode ??
            SettingsHelper.getSystemLocale().languageCode,
      );
    } catch (e) {
      debugPrint('Error loading settings: $e');
      return SettingsState();
    }
  }

  Future<void> updateUnit(UnitModel newUnit) async {
    try {
      final currentState = state.valueOrNull ?? SettingsState();
      final unit = currentState.unit;
      if (unit == newUnit) return;

      await _settingsService.saveSettings(currentState.copyWith(unit: newUnit));

      state = AsyncValue.data(currentState.copyWith(unit: newUnit));
    } catch (e) {
      debugPrint('Error updating unit: $e');
    }
  }

  Future<void> updateLocale(String locCode) async {
    try {
      final currentState = state.valueOrNull ?? SettingsState();
      final localeCode = currentState.localeCode;
      if (localeCode == locCode) return;

      await _settingsService.saveSettings(
        currentState.copyWith(localeCode: locCode),
      );

      state = AsyncValue.data(currentState.copyWith(localeCode: locCode));
    } catch (e) {
      debugPrint('Error updating locale: $e');
      final currentState = state.valueOrNull ?? SettingsState();
      state = AsyncValue.data(currentState);
    }
  }
}

//------------PROVIDERS------------
final settingsProvider = AsyncNotifierProvider<SettingsNotifier, SettingsState>(
  SettingsNotifier.new,
);

final unitProvider = Provider<UnitModel>((ref) {
  return ref
      .watch(settingsProvider)
      .when(
        data: (settings) => settings.unit ?? SettingsHelper.getSystemUnit(),
        error: (_, _) => SettingsHelper.getSystemUnit(),
        loading: () => SettingsHelper.getSystemUnit(),
      );
});

final languageCodeProvider = Provider<String>((ref) {
  return ref
      .watch(settingsProvider)
      .when(
        data: (settings) =>
            settings.localeCode ??
            SettingsHelper.getSystemLocale().languageCode,
        error: (_, _) => SettingsHelper.getSystemLocale().languageCode,
        loading: () => SettingsHelper.getSystemLocale().languageCode,
      );
});

final localeProvider = Provider<Locale>((ref) {
  final code = ref.watch(languageCodeProvider);
  return Locale(code);
});

final formatHelperProvider = Provider<FormatHelper>((ref) {
  final locale = ref.watch(languageCodeProvider);
  final unit = ref.watch(unitProvider);
  return FormatHelper(unit, locale);
});
