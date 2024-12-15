// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TripAdapter extends TypeAdapter<Trip> {
  @override
  final int typeId = 0;

  @override
  Trip read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Trip(
      location: fields[0] as String?,
      startDate: fields[1] as DateTime?,
      endDate: fields[2] as DateTime?,
      selectedNumberOfPeople: fields[3] as String?,
      selectedTripType: fields[4] as String?,
      expance: fields[5] as String?,
      imageFile: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Trip obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.location)
      ..writeByte(1)
      ..write(obj.startDate)
      ..writeByte(2)
      ..write(obj.endDate)
      ..writeByte(3)
      ..write(obj.selectedNumberOfPeople)
      ..writeByte(4)
      ..write(obj.selectedTripType)
      ..writeByte(5)
      ..write(obj.expance)
      ..writeByte(6)
      ..write(obj.imageFile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
