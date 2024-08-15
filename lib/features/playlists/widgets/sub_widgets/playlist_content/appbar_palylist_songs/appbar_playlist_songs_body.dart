import 'package:flutter/material.dart';
import '../../../../../../core/helpers/navigation.dart';
import '../../../../../../core/shared_widgets/custom_icon_buttons.dart';
import '../../../../../../core/styling/app_colors.dart';
import '../../../../../../core/constant/app_icon.dart';
import '../../../../data/model/playlist_model.dart';
import 'action_button_playlist_songs.dart';

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
