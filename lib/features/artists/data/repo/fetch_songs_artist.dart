import 'package:just_music/features/songs/data/model/song.dart';
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
    final listSongsArtist = await _onAudioQuery.queryAudiosFrom(
      AudiosFromType.ARTIST_ID,
      artistId,
      sortType: SongSortType.DATE_ADDED,
      orderType: OrderType.ASC_OR_SMALLER,
      ignoreCase: true,
    );

    List<Song> listSongs = [];

    for (var song in listSongsArtist) {
      final artwork =
          await _onAudioQuery.queryArtwork(artistId, ArtworkType.ARTIST);
      listSongs.add(Song.fromDevice(song, artwork));
    }

    return listSongs;
  }
}
