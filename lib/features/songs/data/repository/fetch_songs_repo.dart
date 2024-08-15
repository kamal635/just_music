import 'dart:io';

import '../model/song.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class FetchSongsFromDeviceRepo {
  Future<List<Song>> fetchSongsFromDevice();
  Future<List<Song>> fetchFixedSongsFromDevice();
}

class FetchSongsFromDeviceRepoImpl implements FetchSongsFromDeviceRepo {
  final OnAudioQuery audioQuery;

  FetchSongsFromDeviceRepoImpl({required this.audioQuery});

  @override
  Future<List<Song>> fetchSongsFromDevice() async {
    final listSongs = await audioQuery.querySongs(
      sortType: SongSortType.DATE_ADDED,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    // Handle songs in chunks
    final listSongsMp3 = <Song>[];

    for (var song in listSongs) {
      final file = File(song.data);

      if (await file.exists() &&
          song.fileExtension == "mp3" &&
          song.duration != 0) {
        final artwork =
            await audioQuery.queryArtwork(song.id, ArtworkType.AUDIO);
        listSongsMp3.add(Song.fromDevice(song, artwork));
      }
    }

    return listSongsMp3;
  }

  @override
  Future<List<Song>> fetchFixedSongsFromDevice() async {
    final listSongs = await audioQuery.querySongs(
      sortType: SongSortType.DATE_ADDED,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    final listSongsMp3 = <Song>[];

    const fixedLenghtSongs = 8;
    final ckcekLenghtSongs = fixedLenghtSongs > listSongs.length
        ? listSongs.length
        : fixedLenghtSongs;

    for (var i = 0; i < ckcekLenghtSongs; i++) {
      final song = listSongs[i];
      final file = File(song.data);

      if (await file.exists() &&
          song.fileExtension == "mp3" &&
          song.duration != 0) {
        final artwork =
            await audioQuery.queryArtwork(song.id, ArtworkType.AUDIO);
        listSongsMp3.add(Song.fromDevice(song, artwork));
      }
    }

    return listSongsMp3;
  }
}
