// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UnitModelAdapter extends TypeAdapter<UnitModel> {
  @override
  final int typeId = 11;

  @override
  UnitModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return UnitModel.standart;
      case 1:
        return UnitModel.metric;
      case 2:
        return UnitModel.imperial;
      default:
        return UnitModel.standart;
    }
  }

  @override
  void write(BinaryWriter writer, UnitModel obj) {
    switch (obj) {
      case UnitModel.standart:
        writer.writeByte(0);
        break;
      case UnitModel.metric:
        writer.writeByte(1);
        break;
      case UnitModel.imperial:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UnitModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
