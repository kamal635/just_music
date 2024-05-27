import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/styling/colors.dart';
import 'package:just_music/core/styling/font.dart';

class SectionImageAndTitlsSong extends StatelessWidget {
  const SectionImageAndTitlsSong({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // image
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Image.asset(
            "assets/images/PedriMobile-1.jpg",
            width: 230.r,
            height: 230.r,
          ),
        ),

        spaceHeight(10),

        // Title Song
        ListTile(
          title: Text(
            "Quzuuana-Aura",
            style: AppFonts.medium_16.copyWith(color: AppColor.white),
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            "Unknown Artist",
            style: AppFonts.normal_12
                .copyWith(color: AppColor.white.withAlpha(140)),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
