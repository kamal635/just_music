import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import '../../features/albums/data/repo/fetch_albums.dart';
import '../../features/albums/data/repo/fetch_songs_album.dart';
import '../../features/albums/logic/albums/albums_bloc.dart';
import '../../features/albums/logic/songs_album/songs_albums_bloc.dart';
import '../../features/artists/data/repo/fetch_artists.dart';
import '../../features/artists/data/repo/fetch_songs_artist.dart';
import '../../features/artists/logic/artists/artists_bloc.dart';
import '../../features/artists/logic/songs_artist/songs_artist_bloc.dart';
import '../../features/favorites/data/repository/favorite_repo.dart';
import '../../features/favorites/logic/favorite_songs/favorite_songs_bloc.dart';
import '../../features/home/data/most_played_repo.dart';
import '../../features/home/data/recently_played_repo.dart';
import '../../features/playlists/data/repository/playlist_repo.dart';
import '../../features/playlists/logic/playlist/playlist_bloc.dart';
import '../../features/songs/data/repository/fetch_songs_repo.dart';
import '../../features/songs/logic/audio_player/audio_player_bloc.dart';
import '../../features/songs/logic/check_permission/check_permission_bloc.dart';
import '../../features/songs/logic/fetch_songs_from_device/fetch_songs_from_device_bloc.dart';
import '../../features/changed_view/logic/search_songs/search_songs_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

final di = GetIt.instance;

Future<void> setUpDependincy() async {
  //======================= Repository ======================
  di.registerLazySingleton<FetchSongsFromDeviceRepoImpl>(
      () => FetchSongsFromDeviceRepoImpl(audioQuery: di()));
  di.registerLazySingleton<FavoriteRepoImpl>(() => FavoriteRepoImpl());
  di.registerLazySingleton<PlaylistRepoImpl>(() => PlaylistRepoImpl());
  di.registerLazySingleton<RecentlyPlayedRepoImpl>(
      () => RecentlyPlayedRepoImpl());
  di.registerLazySingleton<MostPlayedRepoImpl>(() => MostPlayedRepoImpl());
  di.registerLazySingleton<FetchArtistsRepoImpl>(
      () => FetchArtistsRepoImpl(onAudioQuery: di()));
  di.registerLazySingleton<FetchSongsArtistImpl>(
      () => FetchSongsArtistImpl(onAudioQuery: di()));
  di.registerLazySingleton<FetchAlbumsRepo>(
      () => FetchAlbumsRepoImpl(onAudioQuery: di()));
  di.registerLazySingleton<FetchSongsAlbumImpl>(
      () => FetchSongsAlbumImpl(onAudioQuery: di()));
  //======================= Bloc ======================
  di.registerFactory<CheckPermissionBloc>(
      () => CheckPermissionBloc(onAudioQuery: di()));
  di.registerFactory<FetchSongsFromDeviceBloc>(
      () => FetchSongsFromDeviceBloc(fetchSongsFromDeviceRepoImpl: di()));
  di.registerFactory<FavoriteSongsBloc>(
    () => FavoriteSongsBloc(favoriteRepoImpl: di()),
  );
  di.registerFactory<SearchSongsBloc>(
      () => SearchSongsBloc(fetchSongsFromDeviceRepoImpl: di()));
  di.registerFactory<PlaylistBloc>(() => PlaylistBloc(playlistRepoImpl: di()));
  di.registerFactory<ArtistsBloc>(
      () => ArtistsBloc(fetchArtistsRepoImpl: di()));
  di.registerFactory<SongsArtistBloc>(
      () => SongsArtistBloc(fetchSongsArtistImpl: di()));
  di.registerFactory<AlbumsBloc>(() => AlbumsBloc(fetchAlbumsRepo: di()));
  di.registerFactory<SongsAlbumsBloc>(
      () => SongsAlbumsBloc(fetchSongsAlbumImpl: di()));
  //======================= External Package ======================
  di.registerFactory<OnAudioQuery>(() => OnAudioQuery());

  //======================= AudioPlayerBloc ======================
  di.registerFactoryParam<AudioPlayerBloc, AudioHandler, void>(
      (audioHandler, _) {
    return AudioPlayerBloc(
      audioHandler: audioHandler,
      recentlyPlayedRepoImpl: di<RecentlyPlayedRepoImpl>(),
      mostPlayedRepoImpl: di<MostPlayedRepoImpl>(),
    );
  });
}
