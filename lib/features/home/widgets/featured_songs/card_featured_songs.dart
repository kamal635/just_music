import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacer.dart';
import '../../../../core/shared_widgets/custom_art_work.dart';
import '../../../../core/styling/app_colors.dart';
import '../../../../core/styling/app_fonts.dart';
import '../../../../core/constant/app_icon.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../songs/data/model/song.dart';

class CardFeaturedHomeView extends StatelessWidget {
  const CardFeaturedHomeView({super.key, required this.song});
  final Song song;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
          color: AppColor.navBottomBar,
          borderRadius: BorderRadius.circular(12.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Art Work
          SizedBox(
            width: 40.w,
            height: 40.h,
            child: CustomArtWork(
              id: song.id,
            ),
          ),

          spaceWidth(6),

          // title song and artist
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  song.title,
                  style: AppFonts.medium_12.copyWith(color: AppColor.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  song.artist ?? AppStrings.unknown,
                  style: AppFonts.normal_10
                      .copyWith(color: AppColor.white.withAlpha(110)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          spaceWidth(6),

          // Icon play
          const IconButton.filled(
              onPressed: null,
              icon: Icon(
                AppIcon.play,
                color: AppColor.lightBlue,
              ))
        ],
      ),
    );
  }
}
