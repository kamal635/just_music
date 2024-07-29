import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/routes/string_route.dart';
import 'package:just_music/core/shared_widgets/custom_loading.dart';
import 'package:just_music/features/playlists/logic/playlist/playlist_bloc.dart';
import 'package:just_music/features/playlists/widgets/create_playlist_button.dart';
import 'package:just_music/features/playlists/widgets/sliver_grid_view_playlist.dart';

class PlayListViewBody extends StatelessWidget {
  const PlayListViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: BlocConsumer<PlaylistBloc, PlaylistState>(
        // Here because I arrange the list according to the time the playlist was created
        //When I create a new playlist, it always becomes the first in the list
        //At index 0, this way I can open the playlist when it is created
        listener: (context, state) {
          final playlists = state.playlist;
          final checkPlaylist = playlists != null &&
              playlists.isNotEmpty &&
              state.playlistStatus == PlaylistStatus.created;

          if (checkPlaylist) {
            final playlistFirst = playlists.first;
            const index = 0;
            Future.delayed(const Duration(milliseconds: 100), () {
              context.pushNamed(RouterName.contentPlaylistBody, arguments: {
                "index": index,
                "playlist": playlistFirst,
              });
            });
          }
        },
        builder: (context, state) {
          // State Loading
          if (state.playlistStatus == PlaylistStatus.loading) {
            return const CustomLoading();
          }

          // State Loaded
          if (state.playlistStatus == PlaylistStatus.loaded ||
              state.playlistStatus == PlaylistStatus.created ||
              state.playlistStatus == PlaylistStatus.remove) {
            final playlists = state.playlist;

            // check if playlist is empty or null
            if (playlists == null || playlists.isEmpty) {
              //* Middle  button
              return const Center(
                child: CreatePlaylistButton(
                  isMiddleButton: true,
                  isTopRightButton: false,
                ),
              ); // Add Playlist
            }

            // if playlist is not empty
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                //* Top right button
                const SliverToBoxAdapter(
                  child: CreatePlaylistButton(
                      isTopRightButton: true,
                      isMiddleButton: false), // Add Playlist
                ),

                sliverPadding(10),

                //* sliver gridview playlist
                SliverGridViewPlaylist(
                    playlists: playlists), // Display list of playlist

                sliverPadding(60),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
