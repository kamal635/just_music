import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CustomArtWork extends StatelessWidget {
  const CustomArtWork(
      {super.key, required this.id, this.radius, this.iconSize});
  final int id;
  final double? radius;
  final double? iconSize;
  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      artworkBorder: BorderRadius.all(Radius.circular(radius ?? 8.r)),
      id: id,
      type: ArtworkType.AUDIO,
      keepOldArtwork: true,
      size: 300,
      quality: 100,
      nullArtworkWidget: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColor.white.withAlpha(140),
        ),
        child: Icon(
          AppIcon.musicNote,
          color: AppColor.primary,
          size: iconSize ?? 22.h,
        ),
      ),
    );
  }
}
