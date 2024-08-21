import 'dart:io';

import '../model/song.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class FetchSongsFromDeviceRepo {
  Future<List<Song>> fetchSongs();
  Future<List<Song>> fetchFixedSongs();
}

class FetchSongsFromDeviceRepoImpl implements FetchSongsFromDeviceRepo {
  final OnAudioQuery audioQuery;

  FetchSongsFromDeviceRepoImpl({required this.audioQuery});

  @override
  Future<List<Song>> fetchSongs() async {
    final songsModel = await audioQuery.querySongs(
      sortType: SongSortType.DATE_ADDED,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    final songs = await Future.wait(
      songsModel
          .where((song) =>
              song.fileExtension == "mp3" &&
              File(song.data).existsSync() &&
              song.duration != 0)
          .map((song) async {
        final artwork =
            await audioQuery.queryArtwork(song.id, ArtworkType.AUDIO);
        return Song.fromDevice(song, artwork);
      }).toList(),
    );

    return songs;
  }

  @override
  Future<List<Song>> fetchFixedSongs() async {
    final songsModel = await audioQuery.querySongs(
      sortType: SongSortType.DATE_ADDED,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    final paginatedSongs = songsModel.take(50).toList();

    final songs = await Future.wait(
      paginatedSongs
          .where((song) =>
              song.fileExtension == "mp3" &&
              File(song.data).existsSync() &&
              song.duration != 0)
          .map((song) async {
        final artwork =
            await audioQuery.queryArtwork(song.id, ArtworkType.AUDIO);
        return Song.fromDevice(song, artwork);
      }).toList(),
    );

    return songs;
  }
}
