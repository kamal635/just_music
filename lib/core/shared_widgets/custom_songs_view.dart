import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/navigation.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/shared_widgets/custom_icon_buttons.dart';
import 'package:just_music/core/shared_widgets/custom_shuffle_and_play_all_buttons.dart';
import 'package:just_music/core/shared_widgets/image_empty_list.dart';
import 'package:just_music/core/styling/app_colors.dart';
import 'package:just_music/core/styling/app_fonts.dart';
import 'package:just_music/core/utils/app_icon.dart';
import 'package:just_music/core/utils/app_images.dart';
import 'package:just_music/features/songs/data/model/song.dart';
import 'package:just_music/features/songs/logic/audio_player/audio_player_bloc.dart';
import 'package:just_music/features/songs/widgets/music_track/music_track_player.dart';
import 'package:just_music/features/songs/widgets/song_card.dart';

class CustomSongsView extends StatelessWidget {
  const CustomSongsView(
      {super.key,
      required this.songs,
      this.image,
      required this.title,
      required this.subTitle});
  final List<Song>? songs;
  final String? image;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    Map<int, double> paddingMap = {
      0: 600,
      1: 550,
      2: 510,
      3: 470,
      4: 430,
      5: 390,
      6: 350,
      8: 310,
      9: 270,
      10: 230,
    };

    double calculatePadding(int lenght) {
      return paddingMap[lenght] ?? 200;
    }

    return Scaffold(
      floatingActionButton: const MusicTrackPlayer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: EdgeInsets.only(left: 12.w),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 120.h,
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
                  final double collapseHeight = 130.h - kToolbarHeight;
                  final bool isCollapsed =
                      constraints.biggest.height <= collapseHeight;

                  return FlexibleSpaceBar(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppFonts.medium_18,
                        ),
                        Visibility(
                          visible: !isCollapsed,
                          child: Text(
                            "$subTitle : ${songs?.length ?? 0} songs",
                            style: AppFonts.normal_8.copyWith(
                              color: AppColor.white.withAlpha(120),
                            ),
                          ),
                        ),
                      ],
                    ),
                    background: Container(
                      color: AppColor.primary,
                    ),
                  );
                },
              ),
            ),
            sliverPadding(20),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: CustomShuffleAndPlayAllButtons(songs: songs),
              ),
            ),
            sliverPadding(20),
            if (songs == null || songs!.isEmpty)
              SliverToBoxAdapter(
                child: ImageEmptyList(image: image ?? AppImages.emptyFavorites),
              )
            else
              SliverList.builder(
                itemCount: songs?.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      context
                          .read<AudioPlayerBloc>()
                          .add(SetAudioEvent(songs: songs!, index: index));
                    },
                    child: SongCard(
                      song: songs![index],
                      hideIndex: 2,
                    ),
                  );
                },
              ),
            sliverPadding(calculatePadding(songs?.length ?? 0)),
          ],
        ),
      ),
    );
  }
}
