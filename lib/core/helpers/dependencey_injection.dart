import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import 'package:just_music/features/favorites/data/repository/favorite_repo.dart';
import 'package:just_music/features/favorites/logic/favorite_songs/favorite_songs_bloc.dart';
import 'package:just_music/features/home/data/most_played_repo.dart';
import 'package:just_music/features/home/data/recently_played_repo.dart';
import 'package:just_music/features/playlists/data/repository/playlist_repo.dart';
import 'package:just_music/features/playlists/logic/playlist/playlist_bloc.dart';
import 'package:just_music/features/songs/data/repository/fetch_songs_repo.dart';
import 'package:just_music/features/songs/logic/audio_player/audio_player_bloc.dart';
import 'package:just_music/features/songs/logic/check_permission/check_permission_bloc.dart';
import 'package:just_music/features/songs/logic/fetch_songs_from_device/fetch_songs_from_device_bloc.dart';
import 'package:just_music/features/changed_view/logic/search_songs/search_songs_bloc.dart';
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
