import 'dart:io';

import 'package:just_music/features/home/data/model/song.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class FetchSongsFromDeviceRepo {
  Future<List<Song>> fetchSongsFromDevice();
}

class FetchSongsFromDeviceRepoImpl implements FetchSongsFromDeviceRepo {
  final OnAudioQuery _audioQuery;

  FetchSongsFromDeviceRepoImpl({required OnAudioQuery audioQuery})
      : _audioQuery = audioQuery;

  @override
  Future<List<Song>> fetchSongsFromDevice() async {
    // fetch songs from device by on_audio_query package
    final listSongs = await _audioQuery.querySongs(
      sortType: SongSortType.DATE_ADDED,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    // list of Song to add song after filttering
    final listSongsMp3 = <Song>[];

    // for loop in songs from _audioQuery
    for (final song in listSongs) {
      // storage file song
      final file = File(song.data);

      // check if file is exists or not
      if (await file.exists() &&
          song.fileExtension == "mp3" &&
          song.duration != 0) {
        //add song to list of songs
        listSongsMp3.add(Song.fromDevice(song));
      }
    }

    return listSongsMp3;
  }
}
