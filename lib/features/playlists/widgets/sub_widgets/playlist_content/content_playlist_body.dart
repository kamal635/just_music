import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/navigation.dart';
import '../../../../../core/helpers/spacer.dart';
import '../../../../../core/routes/string_route.dart';
import '../../../../../core/styling/app_colors.dart';
import '../../../../../core/styling/app_fonts.dart';
import '../../../../../core/constant/app_icon.dart';
import '../../../../../core/constant/app_strings.dart';
import '../../../data/model/playlist_model.dart';
import '../../../logic/playlist/playlist_bloc.dart';
import 'appbar_palylist_songs/appbar_playlist_songs_body.dart';
import 'list_of_songs_content.dart';
import 'button_middle_content.dart';
import 'image_title_buttons_content.dart';
import '../../../../songs/widgets/music_track/music_track_player.dart';

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
        padding: EdgeInsets.only(left: 12.w),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
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
                              spaceWidth(12),
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

            sliverPadding(60),
          ],
        ),
      ),
    );
  }
}
