// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherModelAdapter extends TypeAdapter<WeatherModel> {
  @override
  final int typeId = 1;

  @override
  WeatherModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherModel(
      id: fields[0] as int,
      main: fields[1] as String,
      description: fields[2] as String,
      iconCode: fields[3] as String,
      temp: fields[4] as double,
      feelsLike: fields[5] as double,
      pressure: fields[6] as int,
      humidity: fields[7] as int,
      visibility: fields[8] as int,
      speed: fields[9] as double,
      degree: fields[10] as int,
      clouds: fields[11] as int,
      rain: fields[12] as double,
      snow: fields[13] as double,
      sunrise: fields[14] as int,
      sunset: fields[15] as int,
      dt: fields[16] as int,
      timezone: fields[17] as int,
      uniqueKey: fields[18] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherModel obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.main)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.iconCode)
      ..writeByte(4)
      ..write(obj.temp)
      ..writeByte(5)
      ..write(obj.feelsLike)
      ..writeByte(6)
      ..write(obj.pressure)
      ..writeByte(7)
      ..write(obj.humidity)
      ..writeByte(8)
      ..write(obj.visibility)
      ..writeByte(9)
      ..write(obj.speed)
      ..writeByte(10)
      ..write(obj.degree)
      ..writeByte(11)
      ..write(obj.clouds)
      ..writeByte(12)
      ..write(obj.rain)
      ..writeByte(13)
      ..write(obj.snow)
      ..writeByte(14)
      ..write(obj.sunrise)
      ..writeByte(15)
      ..write(obj.sunset)
      ..writeByte(16)
      ..write(obj.dt)
      ..writeByte(17)
      ..write(obj.timezone)
      ..writeByte(18)
      ..write(obj.uniqueKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
