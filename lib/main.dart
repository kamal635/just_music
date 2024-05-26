import 'package:flutter/material.dart';
import 'package:just_music/features/home/home_view.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";

void main() {
  runApp(const JustMusicApp());
}

class JustMusicApp extends StatelessWidget {
  const JustMusicApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const HomeView(),
      ),
    );
  }
}
