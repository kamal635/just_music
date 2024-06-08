import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/features/home/data/model/song.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SectionImageAndTitlsSong extends StatelessWidget {
  const SectionImageAndTitlsSong({super.key, required this.song});
  final Song song;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //image
        SizedBox(
          width: 400.r,
          height: 400.r,
          child: QueryArtworkWidget(
            id: song.id,
            type: ArtworkType.AUDIO,
            artworkFit: BoxFit.fill,
            nullArtworkWidget: Image.asset(
              "assets/images/PedriMobile-1.jpg",
            ),
          ),
        ),

        spaceHeight(10),

        // Title Song
        ListTile(
          title: Text(
            song.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: AppFonts.medium_14.copyWith(color: AppColor.white),
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            song.artist ?? "<Unknown>",
            style: AppFonts.normal_10
                .copyWith(color: AppColor.white.withAlpha(140), height: 2.2),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
