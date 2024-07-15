import 'package:flutter/material.dart';
import 'package:just_music/changed_view.dart';
import 'package:just_music/core/routes/string_route.dart';
import 'package:just_music/features/albums/album_view.dart';
import 'package:just_music/features/favorites/favorite_view.dart';
import 'package:just_music/features/folders/folders_view.dart';
import 'package:just_music/features/songs/songs_view.dart';
import 'package:just_music/features/playlists/playlist_view.dart';
import 'package:just_music/features/songs/widgets/search/search_view_body.dart';

abstract class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final argumant = settings.arguments;

    switch (settings.name) {
      case RouterName.changedView:
        return MaterialPageRoute(builder: (context) => const ChangedView());

      case RouterName.songsView:
        return MaterialPageRoute(builder: (context) => const SongsView());

      case RouterName.albumView:
        return MaterialPageRoute(builder: (context) => const AlbumView());

      case RouterName.playListView:
        return MaterialPageRoute(builder: (context) => const PlayListView());

      case RouterName.foldersView:
        return MaterialPageRoute(builder: (context) => const FoldersView());

      case RouterName.favoriteView:
        return MaterialPageRoute(builder: (context) => const FavoriteView());

      case RouterName.listOfSongsView:
        return MaterialPageRoute(builder: (context) => const SearchViewBody());
    }
    // When route is not exist
    return MaterialPageRoute(
        builder: (context) => const Scaffold(
              body: Center(child: Text("Oops..This route is not exist..!")),
            ));
  }
}
