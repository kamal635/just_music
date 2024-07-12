import 'dart:io';

import 'package:just_music/features/songs/data/model/song.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class FetchSongsFromDeviceRepo {
  Future<List<Song>> fetchSongsFromDevice();
}

class FetchSongsFromDeviceRepoImpl implements FetchSongsFromDeviceRepo {
  final OnAudioQuery audioQuery;

  FetchSongsFromDeviceRepoImpl({required this.audioQuery});

  @override
  Future<List<Song>> fetchSongsFromDevice() async {
    // fetch songs from device by on_audio_query package
    final listSongs = await audioQuery.querySongs(
      sortType: SongSortType.DATE_ADDED,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    // list of Song to add song after filttering
    final listSongsMp3 = <Song>[];

    // Process songs asynchronously
    await Future.forEach(listSongs, (song) async {
      // Storage file song
      final file = File(song.data);

      // Check if file exists and other conditions
      if (await file.exists() &&
          song.fileExtension == "mp3" &&
          song.duration != 0) {
        // Add song to list of songs
        listSongsMp3.add(Song.fromDevice(song));
      }
    });

    return listSongsMp3;
  }
}
