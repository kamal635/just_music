// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'most_played_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MostPlayedModelAdapter extends TypeAdapter<MostPlayedModel> {
  @override
  final int typeId = 5;

  @override
  MostPlayedModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MostPlayedModel(
      song: fields[0] as Song,
      playCount: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MostPlayedModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.song)
      ..writeByte(1)
      ..write(obj.playCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MostPlayedModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
