import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import 'package:just_music/features/home/data/repository/get_all_songs_repo.dart';
import 'package:just_music/features/home/data/repository/my_audio_handler.dart';
import 'package:just_music/features/home/logic/audio_player/audio_player_bloc.dart';
import 'package:just_music/features/home/logic/check_permission/check_permission_bloc.dart';
import 'package:just_music/features/home/logic/fetch_songs_from_device/fetch_songs_from_device_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

final di = GetIt.instance;

Future<void> setUpDependincy() async {
  //======================= Bloc ======================
  di.registerFactory<CheckPermissionBloc>(
      () => CheckPermissionBloc(onAudioQuery: di()));

  di.registerFactory<FetchSongsFromDeviceBloc>(
      () => FetchSongsFromDeviceBloc(getAllSongsRepoImpl: di()));

  di.registerFactory<AudioPlayerBloc>(
      () => AudioPlayerBloc(audioHandler: di()));

  //======================= Repository ======================

  di.registerLazySingleton<FetchSongsFromDeviceRepoImpl>(
      () => FetchSongsFromDeviceRepoImpl(audioQuery: di()));

  //======================= External Package ======================

  di.registerFactory<OnAudioQuery>(() => OnAudioQuery());

  di.registerLazySingleton<AudioHandler>(() => MyAudioHandler());
}
