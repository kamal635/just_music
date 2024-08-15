import '../model/album.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class FetchAlbumsRepo {
  Future<List<Album>> fetchAlbums();
}

class FetchAlbumsRepoImpl implements FetchAlbumsRepo {
  final OnAudioQuery _onAudioQuery;

  FetchAlbumsRepoImpl({required OnAudioQuery onAudioQuery})
      : _onAudioQuery = onAudioQuery;

  @override
  Future<List<Album>> fetchAlbums() async {
    final listAlbumModel = await _onAudioQuery.queryAlbums(
      sortType: AlbumSortType.NUM_OF_SONGS,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    List<Album> listAlbum = [];

    for (var album in listAlbumModel) {
      listAlbum.add(Album.fromDevice(album));
    }

    return listAlbum;
  }
}
