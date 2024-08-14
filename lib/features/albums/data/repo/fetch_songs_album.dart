import 'package:just_music/features/songs/data/model/song.dart';
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
    final listSongsAlbum = await _onAudioQuery.queryAudiosFrom(
      AudiosFromType.ALBUM_ID,
      albumId,
      sortType: SongSortType.DATE_ADDED,
      orderType: OrderType.ASC_OR_SMALLER,
      ignoreCase: true,
    );

    List<Song> listSongs = [];

    for (var song in listSongsAlbum) {
      final artwork =
          await _onAudioQuery.queryArtwork(albumId, ArtworkType.ALBUM);
      listSongs.add(Song.fromDevice(song, artwork));
    }

    return listSongs;
  }
}
