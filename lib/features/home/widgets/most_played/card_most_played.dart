import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/custom_art_work.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/features/home/models/most_played_model.dart';

class CardMostPlayed extends StatelessWidget {
  const CardMostPlayed({super.key, required this.mostPlayedModel});
  final MostPlayedModel mostPlayedModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 12.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColor.navBottomBar,
        borderRadius: BorderRadius.circular(12.r),
      ),
      height: 120.h,
      width: 120.w,
      child: Column(
        children: [
          CustomArtWork(
            id: mostPlayedModel.song.id,
            radius: 40,
          ),
          spaceHeight(12),
          Expanded(
            child: Text(
              mostPlayedModel.song.title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppFonts.normal_12,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                AppIcon.headPhone,
                size: 12.h,
                color: AppColor.white.withAlpha(110),
              ),
              spaceWidth(6),
              Text(
                "${mostPlayedModel.playCount}",
                style: AppFonts.normal_12
                    .copyWith(color: AppColor.white.withAlpha(110)),
              )
            ],
          )
        ],
      ),
    );
  }
}
