import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/core/utils/app_strings.dart';

class CustomTitleFeatureHomeView extends StatelessWidget {
  const CustomTitleFeatureHomeView(
      {super.key, required this.title, required this.onTap});
  final String title;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 12.w),
      child: Row(
        children: [
          // title  Recently Played
          Text(
            title,
            style: AppFonts.medium_18,
          ),
          const Spacer(),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: onTap,
            child: Row(
              children: [
                // Text "More"
                Text(
                  AppStrings.more,
                  style: AppFonts.medium_14
                      .copyWith(color: AppColor.white.withAlpha(180)),
                ),

                spaceWidth(4),

                // Icon Arrow
                Icon(
                  AppIcon.arrowForward,
                  size: 12.h,
                  color: AppColor.white.withAlpha(180),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
