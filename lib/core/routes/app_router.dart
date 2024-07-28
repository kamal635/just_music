import 'package:flutter/material.dart';
import 'package:just_music/changed_view.dart';
import 'package:just_music/core/routes/string_route.dart';
import 'package:just_music/features/favorites/favorite_view.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/playlist_content/add_songs_to_playlist/add_songs_to_playlist_body.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/playlist_content/add_songs_to_playlist/extends_classes_from_list_of_songs.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/playlist_content/content_playlist_body.dart';
import 'package:just_music/features/songs/songs_view.dart';
import 'package:just_music/features/playlists/playlist_view.dart';
import 'package:just_music/features/songs/widgets/search/search_view_body.dart';

abstract class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final argument = settings.arguments as Map?;

    switch (settings.name) {
      case RouterName.changedView:
        return MaterialPageRoute(builder: (context) => const ChangedView());

      case RouterName.songsView:
        return MaterialPageRoute(builder: (context) => const SongsView());

      case RouterName.playListView:
        return MaterialPageRoute(builder: (context) => const PlayListView());

      case RouterName.favoriteView:
        return MaterialPageRoute(builder: (context) => const FavoriteView());

      case RouterName.listOfSongsView:
        return MaterialPageRoute(builder: (context) => const SearchViewBody());

      case RouterName.contentPlaylistBody:
        return MaterialPageRoute(builder: (context) {
          return ContentPlaylistBody(
            index: argument?["index"],
            playlist: argument?["playlist"],
          );
        });

      case RouterName.addSongsToPlayListsBody:
        return MaterialPageRoute(
            builder: (context) => AddSongsToPlayListsBody(
                  playlistComeFromPreviousPage: argument?["playlist"],
                ));

      case RouterName.listOfSongsFavoriteToAddToAddToPlaylist:
        return MaterialPageRoute(
            builder: (context) => SongsFavoriteToAddToPlaylist(
                  playlistComeFromPreviousPage:
                      argument?["playlistComeFromPreviousPage"],
                  favoriteSong: argument?["favoriteSong"],
                  playlist: argument?["playlistComeFromPreviousPage"],
                ));

      case RouterName.listOfSongsLocalSongsToAddToAddToPlaylist:
        return MaterialPageRoute(
            builder: (context) => SongsLocalToAddToPlaylist(
                  playlistComeFromPreviousPage:
                      argument?["playlistComeFromPreviousPage"],
                  songs: argument?["songs"],
                  playlist: argument?["playlistComeFromPreviousPage"],
                ));

      case RouterName.listOfSongsPlaylistSongsToAddToAddToPlaylist:
        return MaterialPageRoute(
            builder: (context) => SongsPlaylistToAddToPlaylist(
                  playlistComeFromPreviousPage:
                      argument?["playlistComeFromPreviousPage"],
                  playlist: argument?["playlist"],
                ));
    }
    // When route is not exist
    return MaterialPageRoute(
        builder: (context) => const Scaffold(
              body: Center(child: Text("Oops..This route is not exist..!")),
            ));
  }
}
