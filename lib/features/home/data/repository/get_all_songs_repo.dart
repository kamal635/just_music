import 'package:on_audio_query/on_audio_query.dart';

abstract class GetAllSongsRepo {
  Future<List<SongModel>> getAllSongs();
}

class GetSongsFromDeviceRepoImpl implements GetAllSongsRepo {
  final OnAudioQuery _audioQuery;

  GetSongsFromDeviceRepoImpl({required OnAudioQuery audioQuery})
      : _audioQuery = audioQuery;

  @override
  Future<List<SongModel>> getAllSongs() async {
    return await _audioQuery.querySongs(
      sortType: SongSortType.DATE_ADDED,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
  }
}
