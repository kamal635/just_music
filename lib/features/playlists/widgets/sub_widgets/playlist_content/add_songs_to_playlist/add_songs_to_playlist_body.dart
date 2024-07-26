import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/features/playlists/data/model/playlist_model.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/playlist_content/add_songs_to_playlist/appbar_add_song_to_playlist.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/playlist_content/add_songs_to_playlist/section_favorite_songs_add_songs_to_playlist.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/playlist_content/add_songs_to_playlist/section_local_songs_add_songs_to_playlist.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/playlist_content/add_songs_to_playlist/section_playlists_add_songs_to_playlist.dart';

class AddSongsToPlayListsBody extends StatelessWidget {
  const AddSongsToPlayListsBody(
      {super.key, required this.playlistComeFromPreviousPage});
  final Playlist playlistComeFromPreviousPage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarAddSongsToPlaylist(),
      body: CustomScrollView(
        slivers: [
          sliverPadding(10),

          // * (Favorite and local songs)
          SliverToBoxAdapter(
            child: Column(
              children: [
                //******* Favorite */
                SectionFavoriteSongsAddSongsToPlaylist(
                    playlistComeFromPreviousPage: playlistComeFromPreviousPage),

                //******* Local */
                SectionLocalSongsAddSongsToPlaylist(
                    playlistComeFromPreviousPage: playlistComeFromPreviousPage)
              ],
            ),
          ),

          // * List of Playlist
          SectionPlaylistsAddSongsToPlaylist(
              playlistComeFromPreviousPage: playlistComeFromPreviousPage),

          sliverPadding(kTextTabBarHeight + 80.h),
        ],
      ),
    );
  }
}
