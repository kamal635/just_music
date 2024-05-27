import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/shared_widgets/background_linear.dart';
import 'package:just_music/features/details_song/widgets/section_image_title_song.dart';
import 'package:just_music/features/details_song/widgets/section_slider_track.dart';
import 'package:just_music/features/details_song/widgets/section_control_button_song.dart';

class DetailsSongViewBody extends StatelessWidget {
  const DetailsSongViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundLinearGradiant(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: const CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // section image and title
                    SectionImageAndTitlsSong(),

                    //Section slider track
                    SectionSliderTrack(),

                    // Section Buttons Transations
                    SectionControlButtonSong(),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
