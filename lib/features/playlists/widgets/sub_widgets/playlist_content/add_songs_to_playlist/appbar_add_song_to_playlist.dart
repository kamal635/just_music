import 'package:flutter/material.dart';
import 'package:just_music/core/shared_widgets/custom_icon_back.dart';
import '../../../../../../core/styling/app_colors.dart';
import '../../../../../../core/styling/app_fonts.dart';
import '../../../../../../core/constant/app_strings.dart';

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
        AppStrings.addSongsToPlaylist,
        style: AppFonts.medium_18,
      ),
      //* Leading Icon
      leading: const CustomIconBack(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
