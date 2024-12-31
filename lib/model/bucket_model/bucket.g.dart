// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bucket.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BucketAdapter extends TypeAdapter<Bucket> {
  @override
  final int typeId = 3;

  @override
  Bucket read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bucket(
      date: fields[1] as DateTime?,
      location: fields[5] as String?,
      description: fields[4] as String?,
      budget: fields[6] as String?,
      imageFile: fields[0] as Uint8List?,
      selectedTripType: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Bucket obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.imageFile)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.selectedTripType)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.location)
      ..writeByte(6)
      ..write(obj.budget);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BucketAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
