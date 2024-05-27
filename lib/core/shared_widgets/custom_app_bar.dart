import 'package:flutter/material.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/icon_buttons.dart';
import 'package:just_music/core/styling/colors.dart';
import 'package:just_music/core/styling/font.dart';
import 'package:just_music/core/styling/icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // properties appbar
      automaticallyImplyLeading: false, // hide default back button
      leadingWidth: double.infinity,

      // to give appbar color
      backgroundColor: AppColor.white,
      flexibleSpace: Container(
        color: AppColor.primary.withAlpha(230),
      ),

      //leading
      leading: Row(
        children: [
          CustomIconButton(
            onPressed: () {},
            icon: AppIcon.arrowBack,
            color: AppColor.orange,
          ),
          spaceWidth(12),
          Text(
            "Songs",
            style: AppFonts.medium_20,
          ),
        ],
      ),

      //  here: action icons
      actions: [
        CustomIconButton(
          onPressed: () {},
          icon: AppIcon.favoriteBorder,
          color: AppColor.orange,
        ),
        CustomIconButton(
          onPressed: () {},
          icon: AppIcon.threeDotVertical,
          color: AppColor.orange,
        ),
        spaceWidth(12)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
