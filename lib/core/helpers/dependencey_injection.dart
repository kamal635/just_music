import 'package:get_it/get_it.dart';
import 'package:just_music/features/home/data/repository/get_all_songs_repo.dart';
import 'package:just_music/features/home/logic/check_permission/check_permission_bloc.dart';
import 'package:just_music/features/home/logic/get_all_songs/get_all_songs_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

final di = GetIt.instance;

Future<void> setUpDependincy() async {
  //======================= Bloc ======================
  di.registerFactory<CheckPermissionBloc>(
      () => CheckPermissionBloc(onAudioQuery: di()));

  di.registerFactory<GetAllSongsBloc>(
      () => GetAllSongsBloc(getAllSongsRepoImpl: di()));

  //======================= Repository ======================

  di.registerLazySingleton<GetAllSongsRepoImpl>(
      () => GetAllSongsRepoImpl(audioQuery: di()));

  //======================= External Package ======================

  di.registerFactory<OnAudioQuery>(() => OnAudioQuery());
}
