// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationModelAdapter extends TypeAdapter<LocationModel> {
  @override
  final int typeId = 0;

  @override
  LocationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationModel(
      lat: fields[0] as double,
      lon: fields[1] as double,
      name: fields[2] as String,
      state: fields[3] as String,
      country: fields[4] as String,
      timezone: fields[5] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, LocationModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.lat)
      ..writeByte(1)
      ..write(obj.lon)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.state)
      ..writeByte(4)
      ..write(obj.country)
      ..writeByte(5)
      ..write(obj.timezone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
