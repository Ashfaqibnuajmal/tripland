// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expance.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpanceAdapter extends TypeAdapter<Expance> {
  @override
  final int typeId = 1;

  @override
  Expance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Expance(
      date: fields[0] as String,
      name: fields[1] as String,
      price: fields[2] as String,
      tripId: fields[4] as String,
    )..id = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, Expance obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.tripId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
