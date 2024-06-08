import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/icon_buttons.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/utils/app_icon.dart';

class SectionSliderTrack extends StatelessWidget {
  const SectionSliderTrack({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // IconButton
        CustomIconButton(onPressed: () {}, icon: AppIcon.musicQueue),

        // Slider Track
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            overlayShape: SliderComponentShape.noOverlay,
            thumbColor: AppColor.orange,
            activeTrackColor: AppColor.orange,
            inactiveTrackColor: AppColor.white.withAlpha(140),
          ),
          child: Slider(
            min: 0,
            max: 1000,
            value: 200,
            onChanged: (onChanged) {},
          ),
        ),

        spaceHeight(10),

        // Time Music
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.h),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("0:17"),
              Text("2:23"),
            ],
          ),
        ),
      ],
    );
  }
}
