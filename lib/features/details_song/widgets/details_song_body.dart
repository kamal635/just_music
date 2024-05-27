import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/shared_widgets/background_linear.dart';
import 'package:just_music/features/details_song/widgets/section_image_title_song.dart';

class DetailsSongViewBody extends StatelessWidget {
  const DetailsSongViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundLinearGradiant(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // section image and title
              SectionImageAndTitlsSong(),

              //Section seek bar
            ],
          ),
        ),
      ),
    );
  }
}
