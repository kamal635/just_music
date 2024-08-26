import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../helpers/bloc_observer.dart';
import '../helpers/dependencey_injection.dart';
import '../styling/app_colors.dart';
import '../../features/home/models/most_played_model.dart';
import '../../features/playlists/data/model/playlist_model.dart';
import '../../features/songs/data/model/duration.g.dart';
import '../../features/songs/data/model/song.dart';
import 'package:hive_flutter/adapters.dart';
import '../../features/songs/data/model/uri.g.dart';

Future<void> initMethod() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ScreenUtil.ensureScreenSize();

  await setUpDependincy();

  await Hive.initFlutter();
  Hive.registerAdapter<Duration>(DurationAdapter());
  Hive.registerAdapter<Song>(SongAdapter());
  Hive.registerAdapter<Playlist>(PlaylistAdapter());
  Hive.registerAdapter<Uri>(UriAdapter());
  Hive.registerAdapter<MostPlayedModel>(MostPlayedModelAdapter());

  Bloc.observer = MyBlocObserver();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: AppColor.navBottomBar,
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}
