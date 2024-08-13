import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/core/shared_widgets/custom_art_work.dart';
import 'package:just_music/core/shared_widgets/custom_icon_buttons.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/features/albums/data/model/album.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SliverAppBarSongsAlbum extends StatelessWidget {
  const SliverAppBarSongsAlbum(
      {super.key, required this.screenHeight, required this.album});
  final double screenHeight;
  final Album album;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: screenHeight / 6,
      floating: true,
      pinned: true,
      backgroundColor: AppColor.primary,
      foregroundColor: AppColor.primary,
      surfaceTintColor: AppColor.primary,

      // Leading
      leading: CustomIconButton(
        onPressed: () {
          context.pop();
        },
        icon: AppIcon.arrowBack,
      ),

      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Calculate if the SliverAppBar is collapsed
          final double collapseHeight = screenHeight / 5 - kToolbarHeight;
          final bool isCollapsed = constraints.biggest.height <= collapseHeight;

          return FlexibleSpaceBar(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  album.album,
                  style: AppFonts.medium_18,
                ),
                Visibility(
                  visible: !isCollapsed,
                  child: Text(
                    "${album.numOfSongs} Songs",
                    style: AppFonts.normal_8.copyWith(
                      color: AppColor.white.withAlpha(200),
                    ),
                  ),
                ),
              ],
            ),

            // Image
            background: Stack(
              fit: StackFit.expand,
              children: [
                CustomArtWork(
                  id: album.id,
                  iconSize: 66.h,
                  artworkType: ArtworkType.ALBUM,
                ),
                Container(
                  color: AppColor.primary.withAlpha(80),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
