import 'package:flutter/material.dart';
import '../../../../core/helpers/spacer.dart';
import '../../../../core/shared_widgets/custom_art_work.dart';
import '../../../../core/styling/app_colors.dart';
import '../../../../core/styling/app_fonts.dart';
import '../../../../core/constant/app_strings.dart';
import '../../data/model/song.dart';

class TitleAndImageMusicTrack extends StatelessWidget {
  const TitleAndImageMusicTrack({super.key, required this.song});
  final Song song;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          //* image
          CustomArtWork(id: song.id),

          spaceWidth(10),

          //* Title
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  song.title,
                  style: AppFonts.medium_14,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  song.artist ?? AppStrings.unknown,
                  style: AppFonts.normal_10
                      .copyWith(color: AppColor.white.withAlpha(140)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
