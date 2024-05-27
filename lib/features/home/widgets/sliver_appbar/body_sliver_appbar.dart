import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/styling/font.dart';
import 'package:just_music/core/styling/icons.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/styling/colors.dart';
import 'package:just_music/features/home/widgets/sliver_appbar/custom_tab_bar.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // property sliver appbar
      floating: true,
      backgroundColor: AppColor.white,
      leadingWidth: double.infinity,
      pinned: true,

      // here: leading icons
      leading: Row(
        children: [
          IconButton(
            color: AppColor.orange,
            icon: Icon(
              size: 24.h,
              AppIcon.menu,
            ),
            onPressed: () {},
          ),
          spaceWidth(12),
          Text(
            "Library",
            style: AppFonts.medium_20,
          ),
        ],
      ),

      //  here: action icons
      actions: [
        IconButton(
          color: AppColor.orange,
          icon: Icon(
            AppIcon.search,
            size: 24.h,
          ),
          onPressed: () {},
        ),
        IconButton(
          color: AppColor.orange,
          icon: Icon(
            AppIcon.settings,
            size: 24.h,
          ),
          onPressed: () {},
        ),
        spaceWidth(12)
      ],

      // to give sliver appbar color
      flexibleSpace: Container(
        color: AppColor.primary.withAlpha(240),
      ),

      // here : TabBar
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomTabBar(),
      ),
    );
  }
}
