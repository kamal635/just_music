import 'package:flutter/material.dart';
import 'package:just_music/changed_view.dart';
import 'package:just_music/core/routes/string_route.dart';
import 'package:just_music/features/albums/album_view.dart';
import 'package:just_music/features/favorites/favorite_view.dart';
import 'package:just_music/features/folders/folders_view.dart';
import 'package:just_music/features/home/home_view.dart';
import 'package:just_music/features/playlists/playlist_view.dart';

abstract class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final argumant = settings.arguments;

    switch (settings.name) {
      // Home View
      case RouterName.homeView:
        return MaterialPageRoute(builder: (context) => const HomeView());

      case RouterName.changedView:
        return MaterialPageRoute(builder: (context) => const ChangedView());

      case RouterName.albumView:
        return MaterialPageRoute(builder: (context) => const AlbumView());

      case RouterName.playListView:
        return MaterialPageRoute(builder: (context) => const PlayListView());

      case RouterName.foldersView:
        return MaterialPageRoute(builder: (context) => const FoldersView());

      case RouterName.favoriteView:
        return MaterialPageRoute(builder: (context) => const FavoriteView());
    }
    // When route is not exist
    return MaterialPageRoute(
        builder: (context) => const Scaffold(
              body: Center(child: Text("Oops..This route is not exist..!")),
            ));
  }
}
