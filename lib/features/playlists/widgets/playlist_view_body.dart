import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/features/playlists/logic/playlist/playlist_bloc.dart';
import 'package:just_music/features/playlists/widgets/create_playlist_button.dart';
import 'package:just_music/features/playlists/widgets/sliver_grid_view.dart';

class PlayListViewBody extends StatelessWidget {
  const PlayListViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: BlocBuilder<PlaylistBloc, PlaylistState>(
        builder: (context, state) {
          // State Loading
          if (state.playlistStatus == PlaylistStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          // State Loaded
          if (state.playlistStatus == PlaylistStatus.loaded) {
            final playlist = state.playlist;

            // check if playlist is empty or null
            if (playlist == null || playlist.isEmpty) {
              //* Middle  button
              return const Center(
                child: CreatePlaylistButton(isMiddleButton: true),
              ); // Add Playlist
            }

            // if playlist is not empty
            return CustomScrollView(
              slivers: [
                //* Top right button
                const SliverToBoxAdapter(
                  child: CreatePlaylistButton(
                      isMiddleButton: false), // Add Playlist
                ),

                sliverPadding(10),

                //* sliver gridview playlist
                const CustomSliverGridView(), // Display list of playlist

                sliverPadding(kTextTabBarHeight + 80.h),
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
