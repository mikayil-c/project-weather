// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_forecast_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyForecastModelAdapter extends TypeAdapter<DailyForecastModel> {
  @override
  final int typeId = 3;

  @override
  DailyForecastModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyForecastModel(
      timezone: fields[0] as int,
      dt: fields[1] as int,
      min: fields[2] as double,
      max: fields[3] as double,
      feelsLike: fields[4] as double,
      pressure: fields[5] as int,
      humidity: fields[6] as int,
      id: fields[7] as int,
      main: fields[8] as String,
      description: fields[9] as String,
      iconCode: fields[10] as String,
      speed: fields[11] as double,
      degree: fields[12] as int,
      clouds: fields[13] as int,
      rain: fields[14] as double,
      snow: fields[15] as double,
      pop: fields[16] as double,
    );
  }

  @override
  void write(BinaryWriter writer, DailyForecastModel obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.timezone)
      ..writeByte(1)
      ..write(obj.dt)
      ..writeByte(2)
      ..write(obj.min)
      ..writeByte(3)
      ..write(obj.max)
      ..writeByte(4)
      ..write(obj.feelsLike)
      ..writeByte(5)
      ..write(obj.pressure)
      ..writeByte(6)
      ..write(obj.humidity)
      ..writeByte(7)
      ..write(obj.id)
      ..writeByte(8)
      ..write(obj.main)
      ..writeByte(9)
      ..write(obj.description)
      ..writeByte(10)
      ..write(obj.iconCode)
      ..writeByte(11)
      ..write(obj.speed)
      ..writeByte(12)
      ..write(obj.degree)
      ..writeByte(13)
      ..write(obj.clouds)
      ..writeByte(14)
      ..write(obj.rain)
      ..writeByte(15)
      ..write(obj.snow)
      ..writeByte(16)
      ..write(obj.pop);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyForecastModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
