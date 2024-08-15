import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helpers/navigation.dart';
import '../../../core/helpers/spacer.dart';
import '../../../core/routes/string_route.dart';
import '../../../core/shared_widgets/custom_loading.dart';
import '../logic/playlist/playlist_bloc.dart';
import 'create_playlist_button.dart';
import 'sliver_grid_view_playlist.dart';

class PlayListViewBody extends StatelessWidget {
  const PlayListViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: BlocConsumer<PlaylistBloc, PlaylistState>(
        listener: (context, state) {
          final playlists = state.playlist;
          final checkPlaylist = playlists != null &&
              playlists.isNotEmpty &&
              state.playlistStatus == PlaylistStatus.created;

          if (checkPlaylist) {
            final playlistFirst = playlists.first;
            const index = 0;
            Future.delayed(
              const Duration(milliseconds: 500),
              () {
                if (context.mounted) {
                  context.pushNamed(RouterName.contentPlaylistBody, arguments: {
                    "index": index,
                    "playlist": playlistFirst,
                  });
                }
              },
            );
          }
        },
        builder: (context, state) {
          if (state.playlistStatus == PlaylistStatus.loading) {
            return const CustomLoading();
          }

          if (state.playlistStatus == PlaylistStatus.loaded ||
              state.playlistStatus == PlaylistStatus.created ||
              state.playlistStatus == PlaylistStatus.remove) {
            final playlists = state.playlist;

            if (playlists == null || playlists.isEmpty) {
              return const Center(
                child: CreatePlaylistButton(
                  isMiddleButton: true,
                  isTopRightButton: false,
                ),
              );
            }

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(
                  child: CreatePlaylistButton(
                      isTopRightButton: true, isMiddleButton: false),
                ),
                sliverPadding(10),
                SliverGridViewPlaylist(playlists: playlists),
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
