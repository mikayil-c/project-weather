import 'package:project_weather/app/constants/hive_constants.dart';
import 'package:project_weather/shared/helpers/settings_helper.dart';
import 'package:project_weather/models/model/unit_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'settings_state.g.dart';

@HiveType(typeId: HiveConstants.settingsTypeId)
class SettingsState extends HiveObject {
  @HiveField(0)
  UnitModel? unit;

  @HiveField(1)
  String? localeCode;

  SettingsState({this.unit, this.localeCode});

  SettingsState.defaultCns() {
    unit = SettingsHelper.getSystemUnit();
    localeCode = SettingsHelper.getSystemLocale().languageCode;
  }

  SettingsState copyWith({UnitModel? unit, String? localeCode}) {
    return SettingsState(
      unit: unit ?? this.unit,
      localeCode: localeCode ?? this.localeCode,
    );
  }
}
