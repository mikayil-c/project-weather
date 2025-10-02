// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsStateAdapter extends TypeAdapter<SettingsState> {
  @override
  final int typeId = 10;

  @override
  SettingsState read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsState(
      unit: fields[0] as UnitModel?,
      localeCode: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SettingsState obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.unit)
      ..writeByte(1)
      ..write(obj.localeCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
