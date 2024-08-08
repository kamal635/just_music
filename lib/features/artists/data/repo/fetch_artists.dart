import 'package:just_music/features/artists/data/model/artists.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class FetchArtistsRepo {
  Future<List<Artist>> fetchArtists();
}

class FetchArtistsRepoImpl implements FetchArtistsRepo {
  final OnAudioQuery _onAudioQuery;

  FetchArtistsRepoImpl({required OnAudioQuery onAudioQuery})
      : _onAudioQuery = onAudioQuery;

  @override
  Future<List<Artist>> fetchArtists() async {
    final listArtistModel = await _onAudioQuery.queryArtists(
      sortType: ArtistSortType.NUM_OF_ALBUMS,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    List<Artist> listArtist = [];

    for (var artist in listArtistModel) {
      listArtist.add(Artist.fromDevice(artist));
    }

    return listArtist;
  }
}
