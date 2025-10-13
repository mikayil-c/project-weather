// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hourly_forecast_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HourlyForecastModelAdapter extends TypeAdapter<HourlyForecastModel> {
  @override
  final int typeId = 2;

  @override
  HourlyForecastModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HourlyForecastModel(
      dt: fields[0] as int,
      temp: fields[1] as double,
      feelsLike: fields[2] as double,
      min: fields[3] as double,
      max: fields[4] as double,
      pressure: fields[5] as int,
      humidity: fields[6] as int,
      id: fields[7] as int,
      main: fields[8] as String,
      description: fields[9] as String,
      iconCode: fields[10] as String,
      clouds: fields[11] as int,
      speed: fields[12] as double,
      degree: fields[13] as int,
      rain: fields[14] as double,
      snow: fields[15] as double,
      visibility: fields[16] as int,
      pop: fields[17] as double,
      pod: fields[18] as String,
      dtTxt: fields[19] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HourlyForecastModel obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.dt)
      ..writeByte(1)
      ..write(obj.temp)
      ..writeByte(2)
      ..write(obj.feelsLike)
      ..writeByte(3)
      ..write(obj.min)
      ..writeByte(4)
      ..write(obj.max)
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
      ..write(obj.clouds)
      ..writeByte(12)
      ..write(obj.speed)
      ..writeByte(13)
      ..write(obj.degree)
      ..writeByte(14)
      ..write(obj.rain)
      ..writeByte(15)
      ..write(obj.snow)
      ..writeByte(16)
      ..write(obj.visibility)
      ..writeByte(17)
      ..write(obj.pop)
      ..writeByte(18)
      ..write(obj.pod)
      ..writeByte(19)
      ..write(obj.dtTxt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HourlyForecastModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
