import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/bloc_observer.dart';
import 'package:just_music/core/helpers/dependencey_injection.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/features/home/data/repository/my_audio_handler.dart';

Future<void> initMethod() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await setUpDependincy();
  await initMyAudioHandler();
  Bloc.observer = MyBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: AppColor.primary.withAlpha(230),
  ));
}
