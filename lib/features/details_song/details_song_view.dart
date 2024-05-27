import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/styling/colors.dart';
import 'package:just_music/core/styling/font.dart';
import 'package:just_music/core/styling/icons.dart';
import 'package:just_music/features/details_song/widgets/details_song_body.dart';

class DetailsSongView extends StatelessWidget {
  const DetailsSongView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: DetailsSongViewBody(),
    );
  }
}

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
          IconButton(
            color: AppColor.orange,
            icon: Icon(
              size: 24.h,
              AppIcon.arrowBack,
            ),
            onPressed: () {},
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
        IconButton(
          color: AppColor.orange,
          icon: Icon(
            AppIcon.favoriteBorder,
            size: 24.h,
          ),
          onPressed: () {},
        ),
        IconButton(
          color: AppColor.orange,
          icon: Icon(
            AppIcon.threeDotVertical,
            size: 24.h,
          ),
          onPressed: () {},
        ),
        spaceWidth(12)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
