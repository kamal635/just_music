import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/shared_widgets/icon_buttons.dart';
import 'package:just_music/core/styling/font.dart';
import 'package:just_music/core/styling/icons.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/styling/colors.dart';

class CardSong extends StatelessWidget {
  const CardSong({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,

      // leading ( image )
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Image.asset(
          "assets/images/PedriMobile-1.jpg",
          height: 42.h,
        ),
      ),

      // trailing ( icon )
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "01:22",
            style: AppFonts.normal_12
                .copyWith(color: AppColor.white.withAlpha(120)),
          ),
          spaceWidth(5),
          CustomIconButton(onPressed: () {}, icon: AppIcon.threeDotVertical),
        ],
      ),

      // title
      title: const Text("Desperado"),
      titleTextStyle: AppFonts.medium_16,

      // subtitle
      subtitle: const Text("Unknown Artist"),
      subtitleTextStyle:
          AppFonts.normal_12.copyWith(color: AppColor.white.withAlpha(120)),
    );
  }
}
