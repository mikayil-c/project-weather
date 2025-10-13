// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hourly_forecast_packet.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HourlyForecastPacketAdapter extends TypeAdapter<HourlyForecastPacket> {
  @override
  final int typeId = 5;

  @override
  HourlyForecastPacket read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HourlyForecastPacket(
      list: (fields[0] as List).cast<HourlyForecastModel>(),
      uniqueKey: fields[2] as String?,
      timezone: fields[3] as int,
      sunrise: fields[4] as int,
      sunset: fields[5] as int,
      fetchedAt: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, HourlyForecastPacket obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.list)
      ..writeByte(1)
      ..write(obj.fetchedAt)
      ..writeByte(2)
      ..write(obj.uniqueKey)
      ..writeByte(3)
      ..write(obj.timezone)
      ..writeByte(4)
      ..write(obj.sunrise)
      ..writeByte(5)
      ..write(obj.sunset);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HourlyForecastPacketAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
