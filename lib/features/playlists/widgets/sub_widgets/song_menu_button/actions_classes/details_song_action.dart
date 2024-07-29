import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/features/playlists/widgets/sub_widgets/song_menu_button/abstract_class_actions_song_menu.dart';

import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/songs/data/model/song.dart';

class DetailSongAction extends SongMenuAction {
  final Song song;

  DetailSongAction(this.song);

  @override
  void execute(BuildContext context) async {
    context.pop();
    await showModalBottomSheet(
      backgroundColor: AppColor.primary,
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to adjust its height
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            spaceHeight(20),
            Text(
              AppStrings.detail,
              textAlign: TextAlign.center,
              style: AppFonts.medium_16,
            ),
            Container(
              // Set a minimum height if needed
              constraints: BoxConstraints(
                minHeight: 200.h, // Minimum height
              ),
              child: ListView.builder(
                shrinkWrap: true, // Shrink to fit content
                physics:
                    const NeverScrollableScrollPhysics(), // Disable scrolling
                itemCount: SongDetail.songDetail(song)
                    .length, // Replace with your item count
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      constraints: BoxConstraints(minWidth: 50.w),
                      child: Text(
                        SongDetail.songDetail(song)[index].title,
                        style: AppFonts.medium_14
                            .copyWith(color: AppColor.white.withAlpha(160)),
                      ),
                    ),
                    title: Text(
                      textAlign: TextAlign.start,
                      SongDetail.songDetail(song)[index].subTitle,
                      style: AppFonts.normal_12.copyWith(color: AppColor.white),
                    ), // Replace with your song title
                  );
                },
              ),
            ),
            spaceHeight(20),
          ],
        );
      },
    );
  }
}

class SongDetail {
  final String title;
  final String subTitle;

  SongDetail({required this.title, required this.subTitle});

  static List<SongDetail> songDetail(Song song) {
    return [
      SongDetail(title: "Name", subTitle: song.title),
      SongDetail(title: "Artist", subTitle: song.artist ?? AppStrings.unknown),
      SongDetail(title: "Size", subTitle: song.album ?? AppStrings.unknown),
      SongDetail(title: "Format", subTitle: ".${song.fileExtension}"),
    ];
  }
}
