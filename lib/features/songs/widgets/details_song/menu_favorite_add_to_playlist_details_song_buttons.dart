import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/shared_widgets/favorite_icon_button.dart';
import '../../../../core/shared_widgets/custom_icon_buttons.dart';
import '../../../playlists/widgets/sub_widgets/song_menu_button/actions_classes/add_to_playlist_action.dart';
import '../../../../core/styling/app_colors.dart';
import '../../../../core/constant/app_icon.dart';
import '../../../playlists/data/model/playlist_model.dart';
import '../../../playlists/widgets/sub_widgets/song_menu_button/song_menu_button.dart';
import '../../data/model/song.dart';

class MenuAndFavoriteAndAddToPlaylistDetailsSongButtons
    extends StatelessWidget {
  const MenuAndFavoriteAndAddToPlaylistDetailsSongButtons(
      {super.key, required this.song});
  final Song song;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //* Add To Playlist
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
          size: 26.h,
        ),

        //** Favorite Icon */
        FavoriteIconButton(song: song),

        //* Song Menu
        SongMenuButton(
          playlist: Playlist(name: ""),
          song: song,
          hideIndex: 2,
        ),
      ],
    );
  }
}
