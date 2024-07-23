import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/core/shared_widgets/custom_elvated_button.dart';
import 'package:just_music/core/shared_widgets/icon_buttons.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/features/playlists/data/model/playlist_model.dart';
import 'package:just_music/features/playlists/logic/playlist/playlist_bloc.dart';
import 'package:just_music/features/songs/data/model/song.dart';

class ListOfSongs extends StatelessWidget {
  final String title;
  final List<Song> songs;
  final Playlist
      playlist; // This shows the current playlist I'm in to add songs from
  final Playlist
      playlistComeFromPreviousPage; // This displays the playlist you initially accessed to add songs to

  const ListOfSongs({
    Key? key,
    required this.title,
    required this.songs,
    required this.playlist,
    required this.playlistComeFromPreviousPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.primary,
        surfaceTintColor: AppColor.primary,
        title: Text(
          title,
          style: AppFonts.medium_16,
        ),
        leading: CustomIconButton(
          onPressed: () => Navigator.pop(context),
          icon: AppIcon.arrowBack,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: CustomElvatedButton(
              widthButton: 80.w,
              onPressed: () {
                context.pop();
              },
              title: "Done",
            ),
          )
        ],
      ),
      body: BlocBuilder<PlaylistBloc, PlaylistState>(
        builder: (context, state) {
          // Find the updated playlist from the state
          final updatedPlaylist = state.playlist!.firstWhere(
            (pl) => pl.id == playlistComeFromPreviousPage.id,
            orElse: () => playlistComeFromPreviousPage,
          );

          return CustomScrollView(
            slivers: [
              SliverList.builder(
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  final song = songs[index];
                  final isAdded = updatedPlaylist.songs?.any(
                          (songInPlaylist) => songInPlaylist.id == song.id) ??
                      false;

                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      trailing: CustomIconButton(
                        onPressed: () {
                          context.read<PlaylistBloc>().add(
                                AddSongToPlaylist(
                                  playlistId: updatedPlaylist.id!,
                                  song: song,
                                ),
                              );
                        },
                        icon: isAdded ? AppIcon.checkMark : AppIcon.add,
                        color: isAdded ? AppColor.folder : AppColor.white,
                        size: 22.h,
                      ),
                      title: Text(
                        song.title,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppFonts.medium_14,
                      ),
                      subtitle: Text(
                        song.artist ?? "<Unknown>",
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppFonts.normal_10.copyWith(
                          color: AppColor.white.withAlpha(120),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
