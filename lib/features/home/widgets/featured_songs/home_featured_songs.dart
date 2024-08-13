import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_music/core/helpers/spacer.dart';
import 'package:just_music/core/utils/app_strings.dart';
import 'package:just_music/features/changed_view/logic/nav_bottom_bar/nav_bottom_bar_bloc.dart';
import 'package:just_music/features/home/widgets/custom_title_feature_home_view.dart';
import 'package:just_music/features/home/widgets/featured_songs/card_featured_songs.dart';
import 'package:just_music/features/songs/logic/audio_player/audio_player_bloc.dart';
import 'package:just_music/features/songs/logic/fetch_songs_from_device/fetch_songs_from_device_bloc.dart';

class HomeFeaturedSongs extends StatelessWidget {
  const HomeFeaturedSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<FetchSongsFromDeviceBloc, FetchSongsFromDeviceState>(
        builder: (context, state) {
          if (state.songs == null || state.songs!.isEmpty) {
            return const SizedBox();
          }
          final songs = state.songs;
          const endIndex = 12;
          final subList = songs?.sublist(
              0, endIndex > songs.length ? songs.length : endIndex);
          return Column(
            children: [
              // title list of featured songs
              CustomTitleFeatureHomeView(
                onTap: () {
                  context
                      .read<NavBottomBarBloc>()
                      .add(const ChangedCurrentPageEvent(index: 1));
                },
                title: AppStrings.featuredSongs,
              ),

              spaceHeight(10),

              // GridView Featured Songs
              Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: SizedBox(
                  height: 160.h,
                  child: GridView.builder(
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    itemCount: subList?.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.h,
                      mainAxisSpacing: 20.w,
                      childAspectRatio: 1 / 5,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(12.r),
                        onTap: () {
                          context
                              .read<AudioPlayerBloc>()
                              .add(SetAudioEvent(songs: songs!, index: index));
                        },
                        child: CardFeaturedHomeView(
                          song: subList![index],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
