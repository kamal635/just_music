import 'package:flutter/material.dart';
import 'package:just_music/core/shared_widgets/icon_buttons.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/home/data/model/song.dart';

class TitleAndFavoriteDetailsSong extends StatelessWidget {
  const TitleAndFavoriteDetailsSong({super.key, required this.song});
  final Song? song;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //**Title */
        Expanded(
          child: ListTile(
            title: Text(
              song!.title,
              style: AppFonts.medium_16,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            subtitle: Text(
              song?.artist ?? AppStrings.unknown,
              style: AppFonts.normal_12
                  .copyWith(color: AppColor.white.withAlpha(140)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ),

        //** Favorite */
        CustomIconButton(onPressed: () {}, icon: AppIcon.favoriteBorder),
      ],
    );
  }
}
