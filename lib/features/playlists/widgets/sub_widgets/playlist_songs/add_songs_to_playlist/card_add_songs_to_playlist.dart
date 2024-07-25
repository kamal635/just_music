import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/shared_widgets/custom_art_work.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/styling/app_linear.dart';
import 'package:just_music/core/utils/app_icon.dart';

class CustomCardAddSongToPlaylist extends StatelessWidget {
  const CustomCardAddSongToPlaylist(
      {super.key,
      this.colorCard,
      this.colorIcon,
      required this.title,
      required this.subtitle,
      this.isArtwork = false,
      this.isTrailing = false,
      this.artworkId,
      this.icon,
      this.index});
  final Color? colorCard;
  final Color? colorIcon;
  final String title;
  final int subtitle;
  final bool isArtwork;
  final bool isTrailing;
  final int? artworkId;
  final IconData? icon;

  final int? index;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: ListTile(
        contentPadding: EdgeInsets.zero,

        //** leading ( image )
        leading: isArtwork
            ? Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  gradient: AppLinear.listLinearPlayList[
                      index! % AppLinear.listLinearPlayList.length],
                ),
                child: CustomArtWork(
                  id: artworkId ?? 0,
                ),
              )
            : Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: colorCard,
                ),
                child: Icon(
                  icon,
                  color: colorIcon,
                  size: 22.h,
                ),
              ),

        //** trailing
        trailing: isTrailing
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    AppIcon.arrowForward,
                    size: 14.h,
                  ),
                ],
              )
            : const SizedBox(),

        //** title
        title: Text(
          title,
          textAlign: TextAlign.start,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        titleTextStyle: AppFonts.medium_14,

        //** subtitle
        subtitle: Text(
          "$subtitle songs",
          textAlign: TextAlign.start,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitleTextStyle:
            AppFonts.normal_10.copyWith(color: AppColor.white.withAlpha(120)),
      ),
    );
  }
}
