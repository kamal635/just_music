import 'package:flutter/material.dart';
import 'package:just_music/features/albums/widgets/songs_album/body_songs_album.dart';
import 'package:just_music/features/artists/widgets/songs_artist/body_songs_artist.dart';
import 'package:just_music/features/changed_view/changed_view.dart';
import 'package:just_music/core/routes/string_route.dart';
import 'package:just_music/features/favorites/favorite_view.dart';
import 'package:just_music/features/home/home_view.dart';
import 'package:just_music/features/home/widgets/most_played/most_played_view.dart';
import 'package:just_music/features/home/widgets/recently_played/recently_palyed_view.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/playlist_content/add_songs_to_playlist/add_songs_to_playlist_body.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/playlist_content/add_songs_to_playlist/extends_classes_from_list_of_songs.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/playlist_content/content_playlist_body.dart';
import 'package:just_music/features/songs/songs_view.dart';
import 'package:just_music/features/playlists/playlist_view.dart';
import 'package:just_music/features/changed_view/widgets/search/search_view_body.dart';

abstract class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final argument = settings.arguments as Map?;

    switch (settings.name) {
      case RouterName.changedView:
        return _buildRoute(const ChangedView());

      case RouterName.recentlyPlayedView:
        return _buildRoute(RecentlyPlayedView(
          recentlyPlayed: argument?["songs"],
        ));

      case RouterName.mostPlayedView:
        return _buildRoute(MostPlayedView(
          songs: argument?["songs"],
        ));
      case RouterName.homeView:
        return _buildRoute(const HomeView());

      case RouterName.songsArtist:
        return _buildRoute(SongsArtist(
          artist: argument?["artist"],
        ));

      case RouterName.songsAlbums:
        return _buildRoute(SongsAlbum(
          album: argument?["album"],
        ));

      case RouterName.songsView:
        return _buildRoute(const SongsView());

      case RouterName.playListView:
        return _buildRoute(const PlayListView());

      case RouterName.favoriteView:
        return _buildRoute(const FavoriteView());

      case RouterName.listOfSongsView:
        return _buildRoute(const SearchViewBody());

      case RouterName.contentPlaylistBody:
        return _buildRoute(ContentPlaylistBody(
          index: argument?["index"],
          playlist: argument?["playlist"],
        ));

      case RouterName.addSongsToPlayListsBody:
        return _buildRoute(AddSongsToPlayListsBody(
          playlistComeFromPreviousPage: argument?["playlist"],
        ));

      case RouterName.listOfSongsFavoriteToAddToAddToPlaylist:
        return _buildRoute(SongsFavoriteToAddToPlaylist(
          playlistComeFromPreviousPage:
              argument?["playlistComeFromPreviousPage"],
          favoriteSong: argument?["favoriteSong"],
          playlist: argument?["playlistComeFromPreviousPage"],
        ));

      case RouterName.listOfSongsLocalSongsToAddToAddToPlaylist:
        return _buildRoute(SongsLocalToAddToPlaylist(
          playlistComeFromPreviousPage:
              argument?["playlistComeFromPreviousPage"],
          songs: argument?["songs"],
          playlist: argument?["playlistComeFromPreviousPage"],
        ));

      case RouterName.listOfSongsPlaylistSongsToAddToAddToPlaylist:
        return _buildRoute(SongsPlaylistToAddToPlaylist(
          playlistComeFromPreviousPage:
              argument?["playlistComeFromPreviousPage"],
          playlist: argument?["playlist"],
        ));
    }
    // When route does not exist
    return _buildRoute(const Scaffold(
      body: Center(child: Text("Oops..This route does not exist..!")),
    ));
  }

  //*** Add Animation when Navigation */
  static PageRouteBuilder _buildRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const beginOffset = Offset(1.0, 0.0);
        const endOffset = Offset.zero;
        const curve = Curves.ease;

        var slideTween = Tween(begin: beginOffset, end: endOffset)
            .chain(CurveTween(curve: curve));
        var fadeTween =
            Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));
        var reverseFadeTween =
            Tween(begin: 1.0, end: 0.0).chain(CurveTween(curve: curve));

        var slideAnimation = animation.drive(slideTween);
        var fadeAnimation = animation.drive(fadeTween);
        var reverseFadeAnimation = secondaryAnimation.drive(reverseFadeTween);

        return SlideTransition(
          position: slideAnimation,
          child: FadeTransition(
            opacity: reverseFadeAnimation,
            child: FadeTransition(
              opacity: fadeAnimation,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
