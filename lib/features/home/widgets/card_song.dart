import 'package:flutter/material.dart';
import 'package:just_music/core/shared_widgets/icon_buttons.dart';
import 'package:just_music/core/styling/font.dart';
import 'package:just_music/core/styling/icons.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/styling/colors.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CardSong extends StatelessWidget {
  const CardSong({super.key, required this.songModel});
  final SongModel songModel;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,

      // leading ( image )
      leading: QueryArtworkWidget(
        id: songModel.id,
        type: ArtworkType.AUDIO,
      ),

      // trailing ( icon )
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${songModel.duration}",
            style: AppFonts.normal_12
                .copyWith(color: AppColor.white.withAlpha(120)),
          ),
          spaceWidth(5),
          CustomIconButton(onPressed: () {}, icon: AppIcon.threeDotVertical),
        ],
      ),

      // title
      title: Text(
        songModel.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      titleTextStyle: AppFonts.medium_16,

      // subtitle
      subtitle: Text(songModel.artist ?? "no artist"),
      subtitleTextStyle:
          AppFonts.normal_12.copyWith(color: AppColor.white.withAlpha(120)),
    );
  }
}
