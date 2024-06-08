import 'package:flutter/material.dart';
import 'package:just_music/core/routes/string_route.dart';
import 'package:just_music/features/details_song/details_song_view.dart';
import 'package:just_music/features/home/data/model/song.dart';
import 'package:just_music/features/home/home_view.dart';

abstract class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final argumant = settings.arguments;

    switch (settings.name) {
      // Home View
      case RouterName.homeView:
        return MaterialPageRoute(builder: (context) => const HomeView());

      // Details Song View
      case RouterName.detailsSongView:
        return MaterialPageRoute(
            builder: (context) => DetailsSongView(
                  song: argumant as Song,
                ));
    }

    // When route is not exist
    return MaterialPageRoute(
        builder: (context) => const Scaffold(
              body: Center(child: Text("Oops..This route is not exist..!")),
            ));
  }
}
