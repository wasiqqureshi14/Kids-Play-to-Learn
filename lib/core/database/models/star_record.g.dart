// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'star_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StarRecordAdapter extends TypeAdapter<StarRecord> {
  @override
  final int typeId = 0;

  @override
  StarRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StarRecord(
      ageGroup: fields[0] as String,
      gameId: fields[1] as String,
      stars: fields[2] as int,
      lastPlayed: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, StarRecord obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.ageGroup)
      ..writeByte(1)
      ..write(obj.gameId)
      ..writeByte(2)
      ..write(obj.stars)
      ..writeByte(3)
      ..write(obj.lastPlayed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StarRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
