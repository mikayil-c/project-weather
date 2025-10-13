// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_forecast_packet.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyForecastPacketAdapter extends TypeAdapter<DailyForecastPacket> {
  @override
  final int typeId = 4;

  @override
  DailyForecastPacket read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyForecastPacket(
      list: (fields[0] as List).cast<DailyForecastModel>(),
      fetchedAt: fields[1] as int?,
      uniqueKey: fields[2] as String?,
      timezone: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DailyForecastPacket obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.list)
      ..writeByte(1)
      ..write(obj.fetchedAt)
      ..writeByte(2)
      ..write(obj.uniqueKey)
      ..writeByte(3)
      ..write(obj.timezone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyForecastPacketAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
