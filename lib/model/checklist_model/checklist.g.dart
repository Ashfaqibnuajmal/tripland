// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChecklistAdapter extends TypeAdapter<Checklist> {
  @override
  final int typeId = 6;

  @override
  Checklist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Checklist(
      name: fields[0] as String,
      tripId: fields[1] as String,
    )..id = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, Checklist obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.tripId)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChecklistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
