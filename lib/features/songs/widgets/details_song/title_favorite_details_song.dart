import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/shared_widgets/favorite_icon_button.dart';
import 'package:just_music/core/shared_widgets/custom_icon_buttons.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/song_menu_button/actions_classes/add_to_playlist_action.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/playlists/data/model/playlist_model.dart';
import 'package:just_music/features/songs/data/model/song.dart';

class TitleAndFavoriteDetailsSong extends StatelessWidget {
  const TitleAndFavoriteDetailsSong({super.key, required this.song});
  final Song song;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //**Title */
        Expanded(
          child: ListTile(
            title: Text(
              song.title,
              style: AppFonts.medium_16,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              song.artist ?? AppStrings.unknown,
              style: AppFonts.normal_12
                  .copyWith(color: AppColor.white.withAlpha(140)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),

        CustomIconButton(
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: AppColor.primary,
              context: context,
              builder: (context) {
                return AddToPlaylistDialog(
                    playlist: Playlist(name: ""), song: song);
              },
            );
          },
          icon: AppIcon.addToPlaylist,
          size: 24.h,
        ),

        //** Favorite Icon */
        FavoriteIconButton(song: song),
      ],
    );
  }
}
