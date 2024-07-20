import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_music/core/helpers/bloc_observer.dart';
import 'package:just_music/core/helpers/dependencey_injection.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/features/playlists/data/model/playlist_model.dart';
import 'package:just_music/features/songs/data/model/duration.g.dart';
import 'package:just_music/features/songs/data/model/song.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> initMethod() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ScreenUtil.ensureScreenSize();

  await setUpDependincy();

  await Hive.initFlutter();
  Hive.registerAdapter<Duration>(DurationAdapter());
  Hive.registerAdapter<Song>(SongAdapter());
  Hive.registerAdapter<Playlist>(PlaylistAdapter());

  Bloc.observer = MyBlocObserver();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: AppColor.primary.withAlpha(230),
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}
