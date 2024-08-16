import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/shared_widgets/custom_icon_back.dart';
import '../helpers/spacer.dart';
import 'custom_shuffle_and_play_all_buttons.dart';
import 'image_empty_list.dart';
import '../styling/app_colors.dart';
import '../styling/app_fonts.dart';
import '../constant/app_images.dart';
import '../../features/songs/data/model/song.dart';
import '../../features/songs/logic/audio_player/audio_player_bloc.dart';
import '../../features/songs/widgets/music_track/music_track_player.dart';
import '../../features/songs/widgets/song_card.dart';

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
    final screenHeight = MediaQuery.of(context).size.height;
    Map<int, double> paddingMap = {
      0: screenHeight,
      1: screenHeight / 2,
      2: screenHeight / 2,
      3: screenHeight / 2,
      4: screenHeight / 2.8,
      5: screenHeight / 2.8,
      6: screenHeight / 2.8,
      7: screenHeight / 2.8,
      8: screenHeight / 7.2,
      9: screenHeight / 7.2,
    };

    double calculatePadding(int lenght) {
      return paddingMap[lenght] ?? screenHeight / 8;
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
              expandedHeight: screenHeight / 6,
              floating: true,
              pinned: true,
              backgroundColor: AppColor.primary,
              foregroundColor: AppColor.primary,
              surfaceTintColor: AppColor.primary,

              // Leading
              leading: const CustomIconBack(),

              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  // Calculate if the SliverAppBar is collapsed
                  final double collapseHeight =
                      screenHeight / 5 - kToolbarHeight;
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
