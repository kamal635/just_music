import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/navigation.dart';
import '../../../../core/shared_widgets/custom_art_work.dart';
import '../../../../core/shared_widgets/custom_icon_buttons.dart';
import '../../../../core/styling/app_colors.dart';
import '../../../../core/styling/app_fonts.dart';
import '../../../../core/constant/app_icon.dart';
import '../../../../core/constant/app_images.dart';
import '../../data/model/artists.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SliverAppBarSongsArtist extends StatelessWidget {
  const SliverAppBarSongsArtist(
      {super.key, required this.screenHeight, required this.artist});
  final double screenHeight;
  final Artist artist;
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
                  artist.artist,
                  style: AppFonts.medium_18,
                ),
                Visibility(
                  visible: !isCollapsed,
                  child: Text(
                    "${artist.numberOfAlbums} Album - ${artist.numberOfTracks} Songs",
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
                  id: artist.id,
                  iconSize: 66.h,
                  artworkType: ArtworkType.ARTIST,
                  isNullImage: true,
                  nullArtworkWidget: AppImages.artist,
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
