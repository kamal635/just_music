import 'dart:io';

import '../../../songs/data/model/song.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class FetchSongsAlbum {
  Future<List<Song>> fetchSongsAlbum(int albumId);
}

class FetchSongsAlbumImpl implements FetchSongsAlbum {
  final OnAudioQuery _onAudioQuery;

  FetchSongsAlbumImpl({required OnAudioQuery onAudioQuery})
      : _onAudioQuery = onAudioQuery;

  @override
  Future<List<Song>> fetchSongsAlbum(int albumId) async {
    final songsAlbum = await _onAudioQuery.queryAudiosFrom(
      AudiosFromType.ALBUM_ID,
      albumId,
      sortType: SongSortType.DATE_ADDED,
      orderType: OrderType.ASC_OR_SMALLER,
      ignoreCase: true,
    );

    final songs = await Future.wait(
      songsAlbum
          .where((song) =>
              song.fileExtension == "mp3" &&
              File(song.data).existsSync() &&
              song.duration != 0)
          .map((song) async {
        final artwork =
            await _onAudioQuery.queryArtwork(song.id, ArtworkType.ALBUM);
        return Song.fromDevice(song, artwork);
      }).toList(),
    );

    return songs;
  }
}
