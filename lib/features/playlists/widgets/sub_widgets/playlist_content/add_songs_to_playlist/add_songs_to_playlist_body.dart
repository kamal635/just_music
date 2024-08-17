import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/spacer.dart';
import '../../../../data/model/playlist_model.dart';
import 'appbar_add_song_to_playlist.dart';
import 'section_favorite_songs_add_songs_to_playlist.dart';
import 'section_local_songs_add_songs_to_playlist.dart';
import 'section_playlists_add_songs_to_playlist.dart';

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
