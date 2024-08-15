import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styling/app_colors.dart';
import '../constant/app_icon.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CustomArtWork extends StatelessWidget {
  const CustomArtWork({
    super.key,
    required this.id,
    this.radius,
    this.iconSize,
    this.colorIcon,
    this.artworkType,
    this.nullArtworkWidget,
    this.isNullImage = false,
  });
  final int id;
  final double? radius;
  final double? iconSize;
  final Color? colorIcon;
  final ArtworkType? artworkType;
  final String? nullArtworkWidget;
  final bool isNullImage;
  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      artworkBorder: BorderRadius.all(Radius.circular(radius ?? 8.r)),
      id: id,
      type: artworkType ?? ArtworkType.AUDIO,
      keepOldArtwork: true,
      size: 300,
      quality: 100,
      nullArtworkWidget: isNullImage
          ? ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                nullArtworkWidget!,
                fit: BoxFit.cover,
              ))
          : Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius ?? 8.r),
                color: AppColor.white.withAlpha(140),
              ),
              child: Icon(
                AppIcon.musicNote,
                color: colorIcon ?? AppColor.primary,
                size: iconSize ?? 22.h,
              ),
            ),
    );
  }
}
