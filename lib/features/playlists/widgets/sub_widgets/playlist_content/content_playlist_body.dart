import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/routes/string_route.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/playlists/data/model/playlist_model.dart';
import 'package:just_music/features/playlists/logic/playlist/playlist_bloc.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/playlist_content/appbar_palylist_songs/appbar_playlist_songs_body.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/playlist_content/list_of_songs_content.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/playlist_content/button_middle_content.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/playlist_content/image_title_buttons_content.dart';
import 'package:just_music/features/songs/widgets/music_track/music_track_player.dart';

class ContentPlaylistBody extends StatelessWidget {
  const ContentPlaylistBody(
      {super.key, required this.playlist, required this.index});
  final Playlist playlist;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const MusicTrackPlayer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBarPlaylistSongsBody(
        playlist: playlist,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: CustomScrollView(
          slivers: [
            // Sectin (Image + Title playlist + buttons play and add song)
            ImageAndTitleAndButtonsContentPlaylist(
              playlist: playlist,
              index: index,
            ),

            // padding height
            sliverPadding(20),

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

            sliverPadding(10),

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
                        child: ButtonMiddleContentPlaylist(
                          playlist: updatedPlaylist,
                        ),
                      )
                    : ListOfSongsContentPlaylist(
                        songs: updatedPlaylist.songs!,
                        playlist: updatedPlaylist);
              },
            ),

            sliverPadding(kTextTabBarHeight + 60.h),
          ],
        ),
      ),
    );
  }
}
