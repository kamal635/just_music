import 'package:flutter/material.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/core/shared_widgets/icon_buttons.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_icon.dart';

class AppBarAddSongsToPlaylist extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarAddSongsToPlaylist({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColor.primary,
      surfaceTintColor: AppColor.primary,
      title: Text(
        "Add songs to playlist",
        style: AppFonts.medium_18,
      ),
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
