import 'package:just_music/features/songs/data/model/song.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class SearchRepo {
  Future<List<Song>> preloadSongs();
}

class SearchRepoImpl implements SearchRepo {
  final OnAudioQuery audioQuery;

  SearchRepoImpl({required this.audioQuery});

  @override
  Future<List<Song>> preloadSongs() async {
    final listSongs = await audioQuery.querySongs(
      sortType: SongSortType.DATE_ADDED,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    // Preload artwork if needed
    final listSongsMp3 = await Future.wait(listSongs.map((song) async {
      final artwork = await audioQuery.queryArtwork(song.id, ArtworkType.AUDIO);
      return Song.fromDevice(song, artwork);
    }));

    return listSongsMp3;
  }
}
