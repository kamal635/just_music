import 'dart:io';

import '../../../songs/data/model/song.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class FetchSongsArtist {
  Future<List<Song>> fetchSongsArtist(int artistId);
}

class FetchSongsArtistImpl implements FetchSongsArtist {
  final OnAudioQuery _onAudioQuery;

  FetchSongsArtistImpl({required OnAudioQuery onAudioQuery})
      : _onAudioQuery = onAudioQuery;

  @override
  Future<List<Song>> fetchSongsArtist(int artistId) async {
    final songsArtist = await _onAudioQuery.queryAudiosFrom(
      AudiosFromType.ARTIST_ID,
      artistId,
      sortType: SongSortType.DATE_ADDED,
      orderType: OrderType.ASC_OR_SMALLER,
      ignoreCase: true,
    );

    final songs = await Future.wait(
      songsArtist
          .where((song) =>
              song.fileExtension == "mp3" &&
              File(song.data).existsSync() &&
              song.duration != 0)
          .map((song) async {
        final artwork =
            await _onAudioQuery.queryArtwork(song.id, ArtworkType.ARTIST);
        return Song.fromDevice(song, artwork);
      }).toList(),
    );

    return songs;
  }
}
