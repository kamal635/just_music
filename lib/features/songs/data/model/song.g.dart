// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongAdapter extends TypeAdapter<Song> {
  @override
  final int typeId = 0;

  @override
  Song read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Song(
      id: fields[0] as int,
      albumId: fields[1] as int?,
      artistId: fields[2] as int?,
      title: fields[3] as String,
      album: fields[4] as String?,
      artist: fields[5] as String?,
      audioUrl: fields[6] as String?,
      fileExtension: fields[7] as String?,
      duration: fields[8] as Duration?,
      artworkUri: fields[9] as Uri?,
      size: fields[10] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Song obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.albumId)
      ..writeByte(2)
      ..write(obj.artistId)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.album)
      ..writeByte(5)
      ..write(obj.artist)
      ..writeByte(6)
      ..write(obj.audioUrl)
      ..writeByte(7)
      ..write(obj.fileExtension)
      ..writeByte(8)
      ..write(obj.duration)
      ..writeByte(9)
      ..write(obj.artworkUri)
      ..writeByte(10)
      ..write(obj.size);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
