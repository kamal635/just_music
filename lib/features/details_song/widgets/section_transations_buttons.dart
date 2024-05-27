import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/icon_buttons.dart';
import 'package:just_music/core/styling/colors.dart';
import 'package:just_music/core/styling/icons.dart';

class ButtonsTransationsDetailsSong extends StatelessWidget {
  const ButtonsTransationsDetailsSong({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left Icon ( Repeat )
        CustomIconButton(
          icon: AppIcon.repeat,
          onPressed: () {},
        ),

        // Icons Middle
        Row(
          children: [
            // Previous Icon
            CustomIconButton(
              icon: AppIcon.skipPrevious,
              onPressed: () {},
            ),

            spaceWidth(10),

            // Play Icon
            IconButton.filled(
                iconSize: 30.h,
                style: IconButton.styleFrom(backgroundColor: AppColor.orange),
                onPressed: () {},
                icon: const Icon(
                  AppIcon.play,
                  color: AppColor.white,
                )),

            spaceWidth(10),

            // Next Icon
            CustomIconButton(
              icon: AppIcon.skipNext,
              onPressed: () {},
            )
          ],
        ),

        // last Icon ( Shuffle )
        CustomIconButton(
          icon: AppIcon.shuffle,
          onPressed: () {},
        )
      ],
    );
  }
}
