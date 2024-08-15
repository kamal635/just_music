import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacer.dart';
import '../../../../core/shared_widgets/custom_shuffle_and_play_all_buttons.dart';
import '../../../../core/styling/app_fonts.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../songs/data/model/song.dart';

class SectionButtonsSongsAlbum extends StatelessWidget {
  const SectionButtonsSongsAlbum({super.key, required this.songs});
  final List<Song> songs;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.songs,
              style: AppFonts.bold_18,
            ),
            spaceHeight(10),
            CustomShuffleAndPlayAllButtons(songs: songs),
          ],
        ),
      ),
    );
  }
}
