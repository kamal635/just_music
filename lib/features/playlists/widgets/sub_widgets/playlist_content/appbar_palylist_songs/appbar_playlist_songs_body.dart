import 'package:flutter/material.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/core/shared_widgets/icon_buttons.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/features/playlists/data/model/playlist_model.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/playlist_content/appbar_palylist_songs/action_button_playlist_songs.dart';

class AppBarPlaylistSongsBody extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarPlaylistSongsBody({super.key, required this.playlist});
  final Playlist playlist;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColor.primary,
      surfaceTintColor: AppColor.primary,

      //* Action Icon
      actions: [
        ActionButtonAppBarPlaylistSongs(playlist: playlist),
      ],

      //* Leading Icon
      leading: CustomIconButton(
        onPressed: () {
          context.pop();
        },
        icon: AppIcon.arrowBack,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
