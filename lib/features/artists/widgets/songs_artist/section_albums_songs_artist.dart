import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/custom_art_work.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SectionAlbumsInSongsArtist extends StatelessWidget {
  const SectionAlbumsInSongsArtist({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.albums,
              style: AppFonts.bold_18,
            ),
            spaceHeight(10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              child: Row(
                children: List.generate(
                  12,
                  (index) {
                    return Container(
                      height: 80.h,
                      width: 100.w,
                      margin: EdgeInsets.only(right: 12.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          //* image Album
                          CustomArtWork(
                            id: 2,
                            iconSize: 66.h,
                            artworkType: ArtworkType.ALBUM,
                          ),

                          // //*icon as image
                          Positioned(
                            left: 5,
                            bottom: 5,
                            right: 5,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Album",
                                    style: AppFonts.medium_12,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                spaceWidth(10),
                                Container(
                                  height: 20.h,
                                  width: 20.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40.r),
                                    color: AppColor.primary,
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      AppIcon.play,
                                      color: AppColor.white,
                                      size: 10.h,
                                    ),
                                    onPressed: null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
