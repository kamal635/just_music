import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/routes/string_route.dart';
import 'package:just_music/core/shared_widgets/list_view_songs.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/playlists/data/model/playlist_model.dart';
import 'package:just_music/features/playlists/logic/playlist/playlist_bloc.dart';
import 'package:just_music/features/playlists/widgets/playlist_songs/appbar_palylist_songs/appbar_playlist_songs_body.dart';
import 'package:just_music/features/playlists/widgets/playlist_songs/button_middle_add_song.dart';
import 'package:just_music/features/playlists/widgets/playlist_songs/section_image_title_buttons.dart';
import 'package:just_music/features/songs/widgets/music_track/music_track_player.dart';

class PlaylistSongsBody extends StatelessWidget {
  const PlaylistSongsBody(
      {super.key, required this.index, required this.playlist});
  final Playlist playlist;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const MusicTrackPlayer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBarPlaylistSongsBody(
        playlist: playlist,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: CustomScrollView(
          slivers: [
            // Sectin (Image + Title playlist + buttons play and add song)
            SectionImageTitleButtons(index: index, playlist: playlist),

            // padding height
            paddingSliver(20),

            // if playlist null or empty show buttons add song Middle or show Button add songs with list of songs
            BlocBuilder<PlaylistBloc, PlaylistState>(
              builder: (context, state) {
                final updatedPlaylist = state.playlist!.firstWhere(
                  (pl) => pl.id == playlist.id,
                  orElse: () => playlist,
                );

                return updatedPlaylist.songs == null ||
                        updatedPlaylist.songs!.isEmpty
                    ? const SliverToBoxAdapter(
                        child: SizedBox(),
                      )
                    : SliverToBoxAdapter(
                        child: InkWell(
                          onTap: () {
                            context.pushNamed(
                              RouterName.addSongsToPlayListsBody,
                              arguments: {"playlist": playlist},
                            );
                          },
                          child: Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: AppColor.white.withAlpha(140),
                                ),
                                child: Icon(
                                  AppIcon.add,
                                  color: AppColor.primary,
                                  size: 22.h,
                                ),
                              ),
                              Text(
                                AppStrings.addSongs,
                                style: AppFonts.medium_12,
                              )
                            ],
                          ),
                        ),
                      );
              },
            ),

            paddingSliver(10),

            // if playlist null or empty show buttons add song or show list of songs
            BlocBuilder<PlaylistBloc, PlaylistState>(
              builder: (context, state) {
                final updatedPlaylist = state.playlist!.firstWhere(
                  (pl) => pl.id == playlist.id,
                  orElse: () => playlist,
                );

                return updatedPlaylist.songs == null ||
                        updatedPlaylist.songs!.isEmpty
                    ? SliverFillRemaining(
                        child: ButtonMiddleAddSong(
                          playlist: updatedPlaylist,
                        ),
                      )
                    : CustomSliverListSongs(songs: updatedPlaylist.songs!);
              },
            ),

            paddingSliver(kTextTabBarHeight + 80.h),
          ],
        ),
      ),
    );
  }
}
