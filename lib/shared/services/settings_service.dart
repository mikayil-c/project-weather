import 'package:project_weather/app/constants/hive_constants.dart';
import 'package:project_weather/models/state/settings_state.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsService {
  Box get settingsBox => Hive.box<SettingsState>(HiveConstants.settingsBoxName);

  SettingsState getSettings() {
    final savedSettings = settingsBox.get(HiveConstants.settingsKey);
    if (savedSettings == null) {
      return SettingsState.defaultCns();
    }
    return savedSettings;
  }

  Future<void> saveSettings(SettingsState settings) async {
    await settingsBox.put(HiveConstants.settingsKey, settings);
  }

  Future<void> clearSettings() async {
    await settingsBox.clear();
  }
}
