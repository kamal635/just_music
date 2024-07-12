import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/dependencey_injection.dart';
import 'package:just_music/core/routes/string_route.dart';
import 'package:just_music/features/songs/logic/check_permission/check_permission_bloc.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/routes/app_router.dart';
import 'package:just_music/features/favorites/logic/favorite_songs/favorite_songs_bloc.dart';
import 'package:just_music/features/songs/logic/audio_player/audio_player_bloc.dart';
import 'package:just_music/features/songs/logic/fetch_songs_from_device/fetch_songs_from_device_bloc.dart';

class JustMusicApp extends StatelessWidget {
  const JustMusicApp({super.key, required this.audioHandler});

  final AudioHandler audioHandler;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AudioPlayerBloc(audioHandler: audioHandler)
              ..add(LoadAudioPlayerEvent()),
          ),
          BlocProvider(
            create: (context) =>
                di<FavoriteSongsBloc>()..add(const LoadFavoriteSongs()),
          ),
          BlocProvider(
            create: (context) =>
                di<FetchSongsFromDeviceBloc>()..add(LoadSongsFromDeviceEvent()),
          ),
          BlocProvider(
            create: (context) =>
                di<CheckPermissionBloc>()..add(StatusPermissionEvent()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColor.primary,
            brightness: Brightness.dark,
          ),
          initialRoute: RouterName.changedView,
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
