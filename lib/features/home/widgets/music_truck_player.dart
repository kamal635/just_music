import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/styling/colors.dart';
import 'package:just_music/core/styling/font.dart';
import 'package:just_music/core/styling/icons.dart';

class MusicTrackPlayer extends StatelessWidget {
  const MusicTrackPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          color: AppColor.primary,
          height: 60.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.asset(
                      "assets/images/PedriMobile-1.jpg",
                      height: 42.h,
                    ),
                  ),

                  spaceWidth(10),

                  // Title
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Desperado",
                        style: AppFonts.medium_14,
                      ),
                      Text(
                        "Unknown Artist-01:22",
                        style: AppFonts.normal_10
                            .copyWith(color: AppColor.white.withAlpha(140)),
                      ),
                    ],
                  ),
                ],
              ),

              // Buttons
              Row(
                children: [
                  IconButton(
                    // Previous button
                    icon: Icon(
                      Icons.skip_previous,
                      size: 22.h,
                    ),
                    onPressed: () {},
                  ),

                  // Stop button
                  IconButton.filled(
                    icon: Icon(
                      AppIcon.play,
                      color: AppColor.white,
                      size: 22.h,
                    ),
                    onPressed: () {},
                    style:
                        IconButton.styleFrom(backgroundColor: AppColor.orange),
                  ),

                  // Next button
                  IconButton(
                    icon: Icon(
                      Icons.skip_next,
                      size: 22.h,
                    ),
                    onPressed: () {},
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
