import 'package:on_audio_query/on_audio_query.dart';

abstract class GetAllSongsRepo {
  Future<List<SongModel>> getAllSongs();
}

class GetAllSongsRepoImpl implements GetAllSongsRepo {
  final OnAudioQuery _audioQuery;

  GetAllSongsRepoImpl({required OnAudioQuery audioQuery})
      : _audioQuery = audioQuery;

  @override
  Future<List<SongModel>> getAllSongs() async {
    return await _audioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
        path: "/storage/emulated/0/Download");
  }
}
