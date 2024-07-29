import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/custom_elvated_button.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/song_menu_button/abstract_class_actions_song_menu.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/playlists/data/model/playlist_model.dart';
import 'package:just_music/features/playlists/logic/playlist/playlist_bloc.dart';
import 'package:just_music/features/songs/data/model/song.dart';

class RemoveFromPlaylistAction implements SongMenuAction {
  final Song song;
  final Playlist? playlist;
  RemoveFromPlaylistAction(this.song, this.playlist);

  @override
  void execute(BuildContext context) {
    context.pop();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(30.h),

          content: const Text(
            AppStrings.deleteSong,
            textAlign: TextAlign.center,
          ),
          contentTextStyle: AppFonts.medium_16,
          // backgroundColor dialog
          backgroundColor: AppColor.secondary,

          // actions : buttons
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Cancel
                CustomElvatedButton(
                  widthButton: 120.w,
                  onPressed: () {
                    context.pop();
                  },
                  title: AppStrings.cancel,
                  colorButton: AppColor.white.withAlpha(80),
                ),

                spaceWidth(10),
                // OK
                CustomElvatedButton(
                  widthButton: 120.w,
                  onPressed: () {
                    context.read<PlaylistBloc>().add(RemoveSongFromPlaylist(
                        playlistId: playlist!.id!, song: song));
                    context.pop();
                  },
                  title: AppStrings.confirm,
                  colorButton: AppColor.primary,
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
