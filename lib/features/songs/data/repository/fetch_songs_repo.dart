import 'dart:io';

import '../model/song.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class FetchSongsFromDeviceRepo {
  Future<List<Song>> fetchSongsFromDevice();
}

class FetchSongsFromDeviceRepoImpl implements FetchSongsFromDeviceRepo {
  final OnAudioQuery audioQuery;

  FetchSongsFromDeviceRepoImpl({required this.audioQuery});

  @override
  Future<List<Song>> fetchSongsFromDevice() async {
    // Fetch all songs but filter them manually to get only the next batch
    final listSongs = await audioQuery.querySongs(
      sortType: SongSortType.DATE_ADDED,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    final listSongsMp3 = <Song>[];

    // // Filter the songs starting from the last loaded song
    // final filteredSongs =
    //     listSongs.where((song) => song.id > lastId).take(batchSize);

    for (var song in listSongs) {
      File file = File(song.data);
      if (file.existsSync() &&
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
