import 'package:flutter/material.dart';
import 'package:just_music/core/routes/app_router.dart';
import 'package:just_music/core/routes/string_route.dart';

import "package:flutter_screenutil/flutter_screenutil.dart";

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
        initialRoute: RouterName.homeView,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
