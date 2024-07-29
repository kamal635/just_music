import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/custom_art_work.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/songs/data/model/song.dart';

class ImageAndTitleDetailsSong extends StatelessWidget {
  const ImageAndTitleDetailsSong({super.key, required this.song});

  final Song song;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: CustomArtWork(
            id: song.id,
            radius: 10.r,
            iconSize: 80.h,
          ),
        ),
        spaceHeight(10),
        ListTile(
          title: Text(
            song.title,
            style: AppFonts.bold_22,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            song.artist ?? AppStrings.unknown,
            style: AppFonts.medium_12
                .copyWith(color: AppColor.white.withAlpha(180)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
