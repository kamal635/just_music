import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/features/details_song/widgets/section_image_title_song.dart';
import 'package:just_music/features/details_song/widgets/section_slider_track.dart';
import 'package:just_music/features/details_song/widgets/section_control_button_song.dart';
import 'package:just_music/features/home/data/model/song.dart';

class DetailsSongViewBody extends StatelessWidget {
  const DetailsSongViewBody({super.key, required this.song});
  final Song song;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // section image and title
                  SectionImageAndTitlsSong(
                    song: song,
                  ),

                  //Section slider track
                  const SectionSliderTrack(),

                  // Section Buttons Transations
                  const SectionControlButtonSong(),
                ],
              ),
            )
          ],
        ));
  }
}
