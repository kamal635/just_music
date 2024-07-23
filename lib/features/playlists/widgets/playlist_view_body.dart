import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/features/playlists/logic/playlist/playlist_bloc.dart';
import 'package:just_music/features/playlists/widgets/middle_button.dart';
import 'package:just_music/features/playlists/widgets/sliver_grid_view.dart';
import 'package:just_music/features/playlists/widgets/top_rifght_button.dart';

class PlayListViewBody extends StatelessWidget {
  const PlayListViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: BlocBuilder<PlaylistBloc, PlaylistState>(
        builder: (context, state) {
          if (state.playlistStatus == PlaylistStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.playlistStatus == PlaylistStatus.loaded) {
            final playlist = state.playlist;
            if (playlist == null || playlist.isEmpty) {
              //* Middle  button
              return const AddPlayListButtonMiddle();
            }
            return CustomScrollView(
              slivers: [
                //* Top right button
                const SliverToBoxAdapter(
                  child: AddPlayListButtonTopRight(),
                ),

                paddingSliver(10),

                //* sliver grig view playlist
                const CustomSliverGridView(),

                paddingSliver(kTextTabBarHeight + 80.h),
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
