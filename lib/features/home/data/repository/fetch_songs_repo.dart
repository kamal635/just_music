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
    final listSongs = await _audioQuery.querySongs(
      sortType: SongSortType.DATE_ADDED,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    final listSongsMp3 =
        listSongs.map((song) => Song.fromDevice(song)).toList();
    final songsMP3 =
        listSongsMp3.where((song) => song.fileExtension == "mp3").toList();

    return songsMP3;
  }
}
