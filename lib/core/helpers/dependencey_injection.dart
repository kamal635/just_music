import 'package:get_it/get_it.dart';
import 'package:just_music/features/favorites/data/repository/favorite_repo.dart';
import 'package:just_music/features/favorites/logic/favorite_songs/favorite_songs_bloc.dart';
import 'package:just_music/features/songs/data/repository/fetch_songs_repo.dart';
import 'package:just_music/features/songs/logic/check_permission/check_permission_bloc.dart';
import 'package:just_music/features/songs/logic/fetch_songs_from_device/fetch_songs_from_device_bloc.dart';
import 'package:just_music/features/songs/logic/search_songs/search_songs_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

final di = GetIt.instance;

Future<void> setUpDependincy() async {
  //======================= Bloc ======================
  di.registerFactory<CheckPermissionBloc>(
      () => CheckPermissionBloc(onAudioQuery: di()));

  di.registerFactory<FetchSongsFromDeviceBloc>(
      () => FetchSongsFromDeviceBloc(fetchSongsFromDeviceRepoImpl: di()));

  di.registerFactory<FavoriteSongsBloc>(
      () => FavoriteSongsBloc(favoriteRepoImpl: di()));
  di.registerFactory<SearchSongsBloc>(
      () => SearchSongsBloc(fetchSongsFromDeviceRepoImpl: di()));

  //======================= Repository ======================

  di.registerLazySingleton<FetchSongsFromDeviceRepoImpl>(
      () => FetchSongsFromDeviceRepoImpl(audioQuery: di()));

  di.registerLazySingleton<FavoriteRepoImpl>(() => FavoriteRepoImpl());

  //======================= External Package ======================

  di.registerFactory<OnAudioQuery>(() => OnAudioQuery());
}
