import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_music/core/routes/app_router.dart';
import 'package:just_music/core/routes/string_route.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/features/home/logic/audio_player/audio_player_bloc.dart';

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
      child: BlocProvider(
        create: (context) => AudioPlayerBloc(audioHandler: audioHandler)
          ..add(LoadAudioPlayerEvent()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: AppColor.primary,
          ),
          initialRoute: RouterName.changedView,
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
