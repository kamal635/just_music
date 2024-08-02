import 'dart:io';
import 'dart:typed_data';

import 'package:audio_service/audio_service.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'song.g.dart';

@HiveType(typeId: 0)
class Song extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int? albumId;
  @HiveField(2)
  final int? artistId;
  @HiveField(3)
  final String title;
  @HiveField(4)
  final String? album;
  @HiveField(5)
  final String? artist;
  @HiveField(6)
  final String? audioUrl;
  @HiveField(7)
  final String fileExtension;
  @HiveField(8)
  final Duration? duration;
  @HiveField(9)
  final Uri? artworkUri;

  const Song({
    required this.id,
    this.albumId,
    this.artistId,
    required this.title,
    this.album,
    this.artist,
    this.audioUrl,
    required this.fileExtension,
    this.duration,
    this.artworkUri,
  });

  factory Song.fromDevice(SongModel songModel, Uint8List? artworkData) {
    // Initialize the artworkUri variable to null
    Uri? artworkUri;

    if (artworkData != null) {
      // Create a temporary directory to store the artwork file
      final Directory tempDir = Directory.systemTemp;

      // Create a file in the temporary directory with the song's id as the filename
      final File file = File("${tempDir.path}/${songModel.id}.jpg");

      // Write the artwork data to the file
      file.writeAsBytesSync(artworkData);

      // Set the artworkUri variable to the Uri of the created file
      artworkUri = file.uri;
    }

    return Song(
      id: songModel.id,
      albumId: songModel.albumId ?? 0,
      artistId: songModel.artistId ?? 0,
      title: songModel.title,
      album: songModel.album ?? AppStrings.unknown,
      artist: songModel.artist ?? AppStrings.unknown,
      audioUrl: songModel.data,
      fileExtension: songModel.fileExtension,
      duration: Duration(milliseconds: songModel.duration ?? 0),
      artworkUri: artworkUri, // Set artworkUri
    );
  }

  factory Song.fromMediaItem(MediaItem mediaItem) {
    try {
      return Song(
        id: int.parse(mediaItem.id),
        duration: mediaItem.duration ?? Duration.zero,
        title: mediaItem.title,
        album: mediaItem.album ?? "<Not Album MediaItem>",
        artist: mediaItem.artist ?? "<Not Artist MediaItem>",
        audioUrl: mediaItem.extras!['audioUrl'],
        fileExtension: mediaItem.extras!['fileExtension'],
        artworkUri: mediaItem.artUri, // Set artworkUri
      );
    } catch (err) {
      throw Exception('Failed to convert MediaItem to Song: $err');
    }
  }
  MediaItem toMediaItem() => MediaItem(
        id: id.toString(),
        album: album,
        artist: artist,
        title: title,
        duration: duration,
        artUri: artworkUri, // Use artworkUri
        extras: <String, dynamic>{
          'audioUrl': audioUrl,
          "fileExtension": fileExtension,
        },
      );

  @override
  List<Object?> get props => [
        id,
        albumId,
        artistId,
        title,
        album,
        artist,
        audioUrl,
        fileExtension,
        duration,
        artworkUri,
      ];
}
