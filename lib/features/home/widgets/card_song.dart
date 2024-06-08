import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/duration.dart';
import 'package:just_music/core/shared_widgets/icon_buttons.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_images.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/home/data/model/song.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CardSong extends StatelessWidget {
  const CardSong({super.key, required this.song});

  final Song song;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,

      // leading ( image )
      leading: QueryArtworkWidget(
        id: song.id,
        type: ArtworkType.AUDIO,
        nullArtworkWidget: ClipRRect(
          borderRadius: BorderRadius.circular(40.r),
          child: Image.asset(AppImages.image1),
        ),
      ),

      // trailing ( icon )
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            song.duration! > const Duration(milliseconds: 3600000)
                ? song.duration!.toFormattedStringWithHours()
                : song.duration!.toFormattedStringWithoutHours(),
            style: AppFonts.normal_10
                .copyWith(color: AppColor.white.withAlpha(120)),
          ),
          spaceWidth(5),
          CustomIconButton(onPressed: () {}, icon: AppIcon.threeDotVertical),
        ],
      ),

      // title
      title: Text(
        song.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      titleTextStyle: AppFonts.medium_14,

      // subtitle
      subtitle: Text(
        song.artist ?? AppStrings.unknown,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitleTextStyle:
          AppFonts.normal_10.copyWith(color: AppColor.white.withAlpha(120)),
    );
  }
}
